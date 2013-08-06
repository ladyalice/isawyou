[1mdiff --git a/Gemfile b/Gemfile[m
[1mindex b7ce0c8..3cc0b66 100644[m
[1m--- a/Gemfile[m
[1m+++ b/Gemfile[m
[36m@@ -4,6 +4,8 @@[m [mgem 'rails', '3.2.13'[m
 gem 'jquery-rails'[m
 gem 'devise', '2.2.5'[m
 gem 'simple_form'[m
[32m+[m[32mgem 'paperclip', '~> 3.0'[m
[32m+[m
 # Bundle edge Rails instead:[m
 # gem 'rails', :git => 'git://github.com/rails/rails.git'[m
 group :production do[m
[1mdiff --git a/Gemfile.lock b/Gemfile.lock[m
[1mindex 1864c0a..6b321bf 100644[m
[1m--- a/Gemfile.lock[m
[1m+++ b/Gemfile.lock[m
[36m@@ -29,10 +29,15 @@[m [mGEM[m
       i18n (= 0.6.1)[m
       multi_json (~> 1.0)[m
     arel (3.0.2)[m
[32m+[m[32m    bcrypt-ruby (3.1.1)[m
     bcrypt-ruby (3.1.1-x86-mingw32)[m
     bootstrap-sass (2.3.2.1)[m
       sass (~> 3.2)[m
     builder (3.0.4)[m
[32m+[m[32m    climate_control (0.0.3)[m
[32m+[m[32m      activesupport (>= 3.0)[m
[32m+[m[32m    cocaine (0.5.1)[m
[32m+[m[32m      climate_control (>= 0.0.3, < 1.0)[m
     coffee-rails (3.2.2)[m
       coffee-script (>= 2.2.0)[m
       railties (~> 3.2.0)[m
[36m@@ -61,6 +66,12 @@[m [mGEM[m
     mime-types (1.23)[m
     multi_json (1.7.7)[m
     orm_adapter (0.4.0)[m
[32m+[m[32m    paperclip (3.5.1)[m
[32m+[m[32m      activemodel (>= 3.0.0)[m
[32m+[m[32m      activesupport (>= 3.0.0)[m
[32m+[m[32m      cocaine (~> 0.5.0)[m
[32m+[m[32m      mime-types[m
[32m+[m[32m    pg (0.14.1)[m
     pg (0.14.1-x86-mingw32)[m
     polyglot (0.3.3)[m
     rack (1.4.5)[m
[36m@@ -101,6 +112,7 @@[m [mGEM[m
       multi_json (~> 1.0)[m
       rack (~> 1.0)[m
       tilt (~> 1.1, != 1.3.0)[m
[32m+[m[32m    sqlite3 (1.3.7)[m
     sqlite3 (1.3.7-x86-mingw32)[m
     thor (0.18.1)[m
     tilt (1.4.1)[m
[36m@@ -122,6 +134,7 @@[m [mDEPENDENCIES[m
   coffee-rails (~> 3.2.1)[m
   devise (= 2.2.5)[m
   jquery-rails[m
[32m+[m[32m  paperclip (~> 3.0)[m
   pg[m
   rails (= 3.2.13)[m
   sass-rails (~> 3.2.3)[m
[1mdiff --git a/app/models/pic.rb b/app/models/pic.rb[m
[1mindex 7fcb7a3..11e6c81 100644[m
[1m--- a/app/models/pic.rb[m
[1m+++ b/app/models/pic.rb[m
[36m@@ -1,7 +1,12 @@[m
 class Pic < ActiveRecord::Base[m
[31m-  attr_accessible :description[m
[32m+[m[32m  attr_accessible :description, :image[m
 [m
[31m-  belongs_to :user[m
   validates :user_id, presence: true[m
   validates :description, presence: true[m
[32m+[m[32m  validates_attachment :image, presence: true[m
[32m+[m[41m  [m								[32mcontent_type: { content_type: ['image/jpeg', 'image/jpg','image/png','image/gif']}[m
[32m+[m[41m  [m								[32msize { less_than: 5.megabytes }[m
[32m+[m[32m  belongs_to :user[m
[32m+[m[32m  has_attached_file :image[m
[32m+[m[41m  [m
 end[m
[1mdiff --git a/app/views/pics/_form.html.erb b/app/views/pics/_form.html.erb[m
[1mindex c4dd188..7dfc9fd 100644[m
[1m--- a/app/views/pics/_form.html.erb[m
[1m+++ b/app/views/pics/_form.html.erb[m
[36m@@ -1,6 +1,8 @@[m
 <%= simple_form_for(@pic, html: {class: "form-horizontal"}) do |f| %>[m
   <%= f.error_notification %>[m
[32m+[m[32m  <%= f.full_error :image_file_size, class: "alert alert-error" %>[m
 [m
[32m+[m[41m  [m	[32m<%= f.input :image, label: "Upload a picture" %>[m
     <%= f.input :description, as: :text, input_html: { rows: "3" } %>[m
 [m
 [m
[1mdiff --git a/app/views/pics/_pic.html.erb b/app/views/pics/_pic.html.erb[m
[1mindex 1dc9ea2..9a4fcba 100644[m
[1m--- a/app/views/pics/_pic.html.erb[m
[1m+++ b/app/views/pics/_pic.html.erb[m
[36m@@ -1,6 +1,11 @@[m
 <tr>[m
     <td><%= pic.description %></td>[m
     <td><%= link_to 'Show', pic %></td>[m
[32m+[m[41m[m
[32m+[m[32m    <% if current_user == pic.user %>[m[41m[m
     <td><%= link_to 'Edit', edit_pic_path(pic) %></td>[m
[31m-    <td><%= link_to 'Destroy', pic, method: :delete, data: { confirm: 'Are you sure?' } %></td>[m
[32m+[m[32m    <td><%= link_to 'Destroy', pic, method: :delete, data: { confirm: 'Are you sure?' } %>[m[41m[m
[32m+[m[41m[m
[32m+[m[3