# HSA Tracker - Rails Backend

This is the Ruby on Rails backend built for the HSA Tracker app. The API has endpoints for users and receipt records, although they require authentication to access. The frontend is built with React JS. For the frontend, see the repo here: https://github.com/Meganmccarty/hsa-tracker-react

## Get your own copy
To create your own copy of this project:
1. Fork this repo
2. Click the green 'Code' button at the top right and copy the link
3. In your terminal, navigate to the directory in which to clone the repo
4. Type `git clone <copied-link>` and hit enter
5. Type `cd hsa-tracker-rails` and hit enter
6. Run `bundle install`
7. Run `rails db:migrate`
    - Optional: edit the `seed.rb` file and add in your own data, then run `rails db:seed`
8. Run `rails s`

The website should open up in a new browser tab at `http://localhost:3000`. The main route shouldn't have anything. If you want to access the `/users` or `/receipt-records` endpoints for testing, you can edit their respective controllers to eliminate the need for authentication:

```
# Example: receipt_records_controller.rb

def index
    # Comment out the line below:
    # receipt_records = current_user.receipt_records.with_attached_receipt_images

    # Replace with the following to access the GET /receipt-records endpoint:
    receipt_records = ReceiptRecord.all.with_attached_receipt_images

    ...

```

### Configure the frontend (optional)
If you want to use this API with the corresponding frontend, please see the README for the frontend repo: https://github.com/Meganmccarty/hsa-tracker-react

## Features
* Full CRUD functionality for receipts
* Ability to attach receipt images and store them on AWS S3 via Active Storage
* Can create, retrieve, and update users
* Ability for users to receive a password reset email in the event they forgot their password

## Resources Used
* Built with Ruby on Rails
* [Active Record](https://guides.rubyonrails.org/active_record_basics.html) for managing the database and migration files
* [Active Storage](https://edgeguides.rubyonrails.org/active_storage_overview.html) in combination with Amazon S3 buckets for image management
* [Devise](https://github.com/heartcombo/devise) for user authentication
* [devise-jwt](https://github.com/waiting-for-dev/devise-jwt) to replace cookie-based authentication in favor of JWT