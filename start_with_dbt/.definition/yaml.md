# YAML - Yet Another Markup Language
a human-readable data serialization format commonly used for configuration files and data exchange. It is designed to be easy to read and write compared to formats like JSON and XML.
### Key Features
* **Readable & Concise** – Uses indentation instead of brackets, making it cleaner than JSON/XML.
* **Supports Complex Data Structures** – Handles lists, dictionaries, and scalars naturally.
* **Widely Used in Configurations** – Popular in DevOps (Kubernetes, Ansible, GitHub Actions, etc.).
* **Supports Comments** – Unlike JSON, YAML allows comments using #.
```yml
name: John Doe
age: 30
is_admin: true
skills:
  - Python
  - SQL
  - Apache Airflow
address:
  city: New York
  zip: 10001
```