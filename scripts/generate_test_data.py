import pandas as pd
import random
from faker import Faker
import os

fake = Faker(["en_US"])

# Ensure output directory exists
output_dir = os.path.join(os.path.dirname(__file__), "generated_data")
os.makedirs(output_dir, exist_ok=True)

# Define possible email domains
email_domains = ["gmail.com", "yahoo.com", "outlook.com"]

# Function to generate a Canadian-style phone number
def generate_canadian_phone():
    return f"+1{random.randint(6400000000, 6999999999)}"

# Generate Publishers (Limited Unique Names)
publisher_names = [
    "Pearson Education", "HarperCollins", "Penguin Random House",
    "Simon & Schuster", "Hachette Book Group", "McGraw-Hill",
    "Oxford University Press", "Wiley", "Springer", "Macmillan"
]
publishers = [{"PublisherID": i, "PublisherName": random.choice(publisher_names)} for i in range(1, 51)]

# Generate Books Only (Most in English)
books = [{"ItemID": i,
         "Title": fake.sentence(nb_words=4).replace(".", ""),
         "ItemLanguage": "English" if random.random() < 0.85 else fake.language_name(),
         "PublisherNum": random.randint(1, 50),
         "Copies": random.randint(1, 20)} for i in range(1, 501)]

# Generate Genres
genres_list = ["Classic", "Fiction", "Technology", "History", "Science Fiction", "Self-Help"]
genres = [{"ItemID": i, "IGenre": random.choice(genres_list)} for i in range(1, 501)]

# Generate Author Names
authors = [{"ItemID": i, "AutName": fake.name()} for i in range(1, 501)]

# Generate Members with Proper Email Domains and Canadian Phone Numbers
members = [{"MemberID": i,
            "MemberName": fake.name(),
            "MemberEmail": f"{fake.first_name().lower()}{random.randint(100,999)}@{random.choice(email_domains)}",
            "PhoneNumber": generate_canadian_phone()} for i in range(100001, 100501)]

# Generate Staff
staff = [{"StaffID": i,
         "StaffName": fake.name(),
         "StaffEmail": f"{fake.first_name().lower()}{random.randint(100,999)}@{random.choice(email_domains)}",
         "PhoneNumber": generate_canadian_phone()} for i in range(1, 51)]

# Generate Realistic Event Names
event_names = ["Summer Book Fair", "Author Meet & Greet", "Library Open House",
               "Technology Workshop", "Writing Contest", "Historical Lecture"]
events = [{"EventID": i,
           "EventName": random.choice(event_names),
           "EventDate": fake.date_this_year(),
           "EventTime": fake.time(),
           "EventLocation": fake.city()} for i in range(1, 101)]

# Generate Borrows
borrows = [{"MemberID": random.randint(100001, 100500),
            "ItemID": random.randint(1, 500),
            "StartDate": fake.date_between(start_date='-2y', end_date='today'),
            "ReturnDate": fake.date_between(start_date='today', end_date='+1y')} for _ in range(2000)]

# Generate Hosts
hosts = [{"StaffID": random.randint(1, 50), "EventID": random.randint(1, 100)} for _ in range(200)]

# Generate Manages
manages = [{"StaffID": random.randint(1, 50), "MemberID": random.randint(100001, 100500)} for _ in range(300)]

# Save datasets to CSV
datasets = {
    "publishers.csv": publishers,
    "items.csv": books,
    "genres.csv": genres,
    "authors.csv": authors,
    "members.csv": members,
    "staff.csv": staff,
    "events.csv": events,
    "borrows.csv": borrows,
    "hosts.csv": hosts,
    "manages.csv": manages
}

# Save to files in the "generated_data" directory
for filename, data in datasets.items():
    pd.DataFrame(data).to_csv(os.path.join(output_dir, filename), index=False)

print(f"Files saved in {output_dir}")
