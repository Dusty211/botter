# README

## Botter

### Setup
- If you want to reset everything: rails db:drop
- rails db:create
- rails db:migrate

- start the server with: rails server
- log into psql with: psql -d botter_development
- test back end using Postman to localhost:3000
- verify expected changes in DB
- you may need to generate the files "id_rsa" and "id_rsa.pub" in the project root dir using ssh-gen because they are gitignored.

## Local smtp server for testing
- https://github.com/rnwood/smtp4dev
- To run: docker run --rm -it -p 5000:80 -p 2525:25 rnwood/smtp4dev
- Go to "http://localhost:5000/" in your browser.