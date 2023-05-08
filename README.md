# README

This app builds on 

1. Modal Forms with Rails using the exaple here:
https://nobrainerprogramming.com/rails-7-modal-forms-with-hotwire-and-bootstrap/

2. Replace Select with Tomselect using the example here:
https://coolrequest.dev/2021/11/25/replace_select2.html 

and it enhances autocomplete with ajax and tomselect selection.

What is the problem? A problem arises when you try to edit records with tomselect as the records do not show up. 
as seen  here: https://stackoverflow.com/questions/75366601/rails-tom-select-how-to-keep-selected-value-in-edit-form

Look at the code at 

* https://github.com/nkokkos/rails_7_modal_form/blob/main/app/views/items/_form.html.erb

* https://github.com/nkokkos/rails_7_modal_form/blob/main/app/javascript/controllers/search_controller.js

* https://github.com/nkokkos/rails_7_modal_form/blob/main/app/controllers/items_controller.rb

to see how this is resolved



