# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


app>views>checkout>index.html.erb

<script src="https://js.stripe.com/v3/"></script>

<% if @order.errors%>
<ul>
<li><%= @order.errors.full_messages %></li>
</ul>
<% end %>

<p><em>Your order is displayed in the shopping cart to the right.</em></p>
<%= form_with url: '/checkout/' do |form| %>
<fieldset>
<legend>Contact Information</legend>
<p>
    <%= form.label :email, "Email" %><br/>
    <%= form.text_field :email %>
</p>
<p>
    <%= form.label :phone_number, "Phone number" %><br/>
    <%= form.text_field :phone_number %>
</p>
</fieldset>
<fieldset>
<legend>Shipping Address</legend>
<p>
    <%= form.label :ship_to_first_name, "First name" %><br/>
    <%= form.text_field :ship_to_first_name %>
</p>
<p>
    <%= form.label :ship_to_last_name, "Last name" %><br/>
    <%= form.text_field :ship_to_last_name %>
</p>
<p>
    <%= form.label :ship_to_address, "Address" %><br/>
    <%= form.text_field :ship_to_address %>
</p>
<p>
    <%= form.label :ship_to_city, "City" %><br/>
    <%= form.text_field :ship_to_city %>
</p>
<p>
    <%= form.label :ship_to_postal_code, "Postal/Zip code" %><br/>
    <%= form.text_field :ship_to_postal_code %>
</p>
<p>
    <%= form.label :ship_to_countrye, "Country" %><br/>
    <%= form.country_select :ship_to_country, priority_countries: ["US","AR","GB", "FR", "DE"] %>
</p>
</fieldset>
<fieldset>
<legend>Billing Information</legend>
<p>
    <%= form.label :card_type, "Credit card type" %><br/>
    <%= form.select :card_type, ["Visa", "MasterCard", "Discover"] %>
    
</p>
<p>
    <%= form.label :card_number, "Card number" %><br/>
    <%= form.text_field :card_number %>
</p>
<p>
    <%= form.label :card_expiration_month, "Expiration month" %><br/>
    <%= form.select :card_expiration_month, (%w(1 2 3 4 5 6 7 8 9 10 11 12)) %>
</p>
<p>
    <%= form.label :card_expiration_yearh, "Expiration month" %><br/>
    <%= form.select :card_expiration_year, (%w(2022 2023 2024 2025 2026 2027 2028 2029 2030)) %>
</p>
<p>
    <%= form.label :card_verification_value, "CVC" %><br/>
    <%= form.text_field :card_verification_value %>
</p>



<p><%= submit_tag "Place Order" %></p>
</form>
<% end %>

<%= tag :meta, :name => "stripe-key", :content => Rails.application.credentials.stripe[:STRIPE_TEST_PUBLISHABLE_KEY] %>
<%= javascript_pack_tag 'checkout'%>






