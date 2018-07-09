---
title: "Tips"
date: 2018-07-09T15:03:17-05:00
tags: [PDF, SQL, QPDF, SSH]
---

This post contains some useful tips related with my daily work in software development like commands, database, ssh, etc. It is mainly as a reference for me, but it could be useful for other person.

# PDF 

* Remove the password from many PDF files and join in single file (**QPDF**): Assuming all pdfs are in the folder and has the same password

``` bash
for F in *; do qpdf --password=<THE_PASSWORD> --decrypt $F d_$F; rm $F; done; qpdf --empty <MERGED_NAME>.pdf --pages *.pdf --; rm d_*.pdf
```

# SQL

* How to know the current connections in Postgres

``` sql
select * from pg_stat_activity where datname = '<SCHEMA>'
```

# SSH

* Permissions for *.ssh* folder and *authorized_keys* file for automatic login with certifcate

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
