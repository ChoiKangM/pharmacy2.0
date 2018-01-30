경북대 약학대학 커뮤니티 만들어 보자
===================================
사용하는 Gem
------------
>gem 'kaminari'  
>gem 'bootstrap4-kaminari-views'  

>gem 'devise'  
>gem 'omniauth-facebook'  
>gem 'omniauth-naver'  
>gem 'omniauth-google-oauth2'  
>gem 'omniauth-kakao'  

>gem 'bootstrap', '~> 4.0.0.beta2.1'  
>gem "font-awesome-rails"  
>gem 'tinymce-rails'  

>gem 'carrierwave', '~> 1.0'  
>gem 'mini_magick'  
>gem "fog-aws"  
>gem 'figaro'  

>gem 'rails-i18n', '~> 4.0.0' # For 4.0.x  
>gem 'devise-i18n'  

>gem 'therubyracer', platforms: :ruby  
>gem 'rails_db'     
  
OmniAuth
------------
>참조 https://github.com/likeliondongguk/devise_sns_sign_up    

###### MVC 설정
>$ rails g controller home index  
>$ rails generate devise:install  
>$ rails generate devise user  
>$ rails generate devise:views  
>$ rails generate devise:controllers user  
>$ rails g migration add_name_to_users name:string  
>$ rails g migration add_proimg_to_users proimg:string  
>$ rails g model identity user:references provider:string uid:string  
>$ rails db:migrate  
>$ bundle exec figaro install  

###### app/views/introductions/index.html.erb
```
<% if user_signed_in? %>
    <%= User.where(email: current_user.email).inspect %>
    <p><%= image_tag "#{current_user.proimg}" %></p>
    <%= link_to('Logout', destroy_user_session_path, :method => :delete) %>
<% else %>
    <%= User.all.inspect %>
    <%User.all.each do |a|%>
      <p><%= image_tag "#{a.proimg}" %></p>
    <%end%>
    <%= link_to('Login', new_user_session_path) %>
<% end %>
```  

###### config/initializers/devise.rb
```
config.omniauth :facebook, "key", "secret"
config.omniauth :naver, "key", "secret"
config.omniauth :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"] 
config.omniauth :kakao, "key", :redirect_path => "/users/auth/kakao/callback"  
```  

###### config/routes
```
Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks' }
  get 'home/index'
  #For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

###### app/models/identity.rb
```
class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider)
  end
end
```
###### app/models/user.rb
```
class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  TEMP_EMAIL_PREFIX = 'jongwon@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?
      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup

      email_is_verified = auth.info.email || (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email
      #프로필 사진 추가부분
      proimg = auth.info.image
      proimg ? proimg.sub!("https","http") : nil
      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth.info.name || auth.extra.nickname ||  auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          proimg: proimg ? proimg : "null",
          password: Devise.friendly_token[0,20]
        )
        user.save!

      end
    end
    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!

    end

    user

  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
```
###### app/controllers/user/omniauth_callbacks_controller.rb
```
class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:instagram, :kakao, :naver, :facebook, :google_oauth2, :line].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
      root_path
  end
end
```
###### config/application.yml
```
GOOGLE_CLIENT_ID: "ID"
GOOGLE_CLIENT_SECRET: "Secret"
```

Bootstrap, 이미지, 폰트. tinymce
-----------------------
### Bootstrap  
>Bootstrap4: https://github.com/twbs/bootstrap-rubygem/blob/master/README.md  
>font-awesome-rails: https://github.com/bokmann/font-awesome-rails  

###### app/assets/stylesheets/application.scss
```
@import "bootstrap";
@import "font-awesome";
@font-face {
  font-family: 'Noto Sans KR';
  font-style: normal;
  font-weight: 100;
  src: url(asset-path('fonts/NotoSansKR-Thin.woff2')) format('woff2'),
       url(asset-path('fonts/NotoSansKR-Thin.woff')) format('woff'),
       url(asset-path('fonts/NotoSansKR-Thin.otf')) format('opentype');
}
@font-face {
  font-family: 'Noto Sans KR';
  font-style: normal;
  font-weight: 300;
  src: url(asset-path('fonts/NotoSansKR-Light.woff2')) format('woff2'),
       url(asset-path('fonts/NotoSansKR-Light.woff')) format('woff'),
       url(asset-path('fonts/NotoSansKR-Light.otf')) format('opentype');
}
@font-face {
   font-family: 'Noto Sans KR';
   font-style: normal;
   font-weight: 400;
   src: url(asset-path('fonts/NotoSansKR-Regular.woff2')) format('woff2'),
        url(asset-path('fonts/NotoSansKR-Regular.woff')) format('woff'),
        url(asset-path('fonts/NotoSansKR-Regular.otf')) format('opentype');
 }
@font-face {
   font-family: 'Noto Sans KR';
   font-style: normal;
   font-weight: 500;
   src: url(asset-path('fonts/NotoSansKR-Medium.woff2')) format('woff2'),
        url(asset-path('fonts/NotoSansKR-Medium.woff')) format('woff'),
        url(asset-path('fonts/NotoSansKR-Medium.otf')) format('opentype');
 }
@font-face {
   font-family: 'Noto Sans KR';
   font-style: normal;
   font-weight: 700;
   src: url(asset-path('fonts/NotoSansKR-Bold.woff2')) format('woff2'),
        url(asset-path('fonts/NotoSansKR-Bold.woff')) format('woff'),
        url(asset-path('fonts/NotoSansKR-Bold.otf'))format('opentype');
 }
@font-face {
   font-family: 'Noto Sans KR';
   font-style: normal;
   font-weight: 900;
   src: url(asset-path('fonts/NotoSansKR-Black.woff2')) format('woff2'),
        url(asset-path('fonts/NotoSansKR-Black.woff')) format('woff'),
        url(asset-path('fonts/NotoSansKR-Black.otf')) format('opentype');
 }
*{
  font-family: 'Noto Sans KR', sans-serif;
}
//color management
.text-muted{ 
    color: #8492a7 !important;
}
.text-primary{ 
    color: #00b5ff !important;
}
.text-success{ 
    color: #00d061 !important;
}
.text-info{ 
    color: #7e55f3 !important;
}
.text-warning{ 
    color: #ffd654 !important;
}
.text-danger{ 
    color: #ff4743 !important;
}
//background-color
.bg-muted{ 
    background-color: #8492a7 !important;
}
.bg-primary{ 
    background-color: #00b5ff !important;
}
.bg-success{ 
    background-color: #00d061 !important;
}
.bg-info{ 
    background-color: #7e55f3 !important;
}
.bg-warning{ 
    background-color: #ffd654 !important;
}
.bg-danger{ 
    background-color: #ff4743 !important;
}

//btn-color
.btn-muted{ 
    border-color: #8492a7 !important;
    background-color: #8492a7 !important;
}
.btn-primary{ 
    border-color: #00b5ff !important;
    background-color: #00b5ff !important;
}
.btn-success{ 
    border-color: #00d061!important;
    background-color: #00d061 !important;
}
.btn-info{ 
    border-color: #7e55f3 !important;
    background-color: #7e55f3 !important;
}
.btn-warning{ 
    border-color: #ffd654 !important;
    background-color: #ffd654 !important;
}
.btn-danger{ 
    border-color: #ff4743 !important;
    background-color: #ff4743 !important;
}


.footer-link{
  color: #3d3d3d;
}
.footer-knup{
  display: flex;
  align-items: center;
}
a{
  color: #000000;
  text-decoration: none;
}
.navbar-brand{
    font-size: 2rem;
    font-weight: bold;
    font-style: italic;
}
.nav-link{
    font-size: 1rem;
}
.background{
    background-color: rgba(187,238,255,0.3);
}
.carousel-inner{
    height: 600px;
}
.round-panel{
  
  margin-right: 3;
  border-radius: 0.25rem;
  width: 98%;
  padding: 0.75rem 0.5rem;
  background-color: rgba(0,196,255,0.3);
  border-color: #b8daff;
}
.img-circular{
  border-radius: 16px;
 -webkit-border-radius: 16px;
 -moz-border-radius: 16px;
}
```

###### app/assets/javasctipts/application.js
```
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require tinymce-jquery
```

###### app/assets/stylesheets/introductions.scss
```
// Place all the styles related to the introductions controller here.
// They will automatically be included in application.css.
// You can use Sass (SCSS) here: http://sass-lang.com/
//고화질
// .introduction{
//     position: relative;
//     height: 60em;
//     background: url(asset-path('introductions/1.jpg')) no-repeat center center fixed;
//     -ms-background-size: cover;
//     -o-background-size: cover;
//     -moz-background-size: cover;
//     -webkit-background-size: cover;
//     background-size: cover;
// }
// .alumnus{
//     position: relative;
//     height: 60em;
//     background: url(asset-path('introductions/2.jpg')) no-repeat center center fixed;
//     -ms-background-size: cover;
//     -o-background-size: cover;
//     -moz-background-size: cover;
//     -webkit-background-size: cover;
//     background-size: cover;
// }
// .graduate{
//     position: relative;
//     height: 60em;
//     background: url(asset-path('introductions/3.png')) no-repeat center center fixed;
//     -ms-background-size: cover;
//     -o-background-size: cover;
//     -moz-background-size: cover;
//     -webkit-background-size: cover;
//     background-size: cover;
// }
// .council{
//     position: relative;
//     height: 60em;
//     background: url(asset-path('introductions/4.jpg')) no-repeat center center fixed;
//     -ms-background-size: cover;
//     -o-background-size: cover;
//     -moz-background-size: cover;
//     -webkit-background-size: cover;
//     background-size: cover;
// }
// .hobby{
//     position: relative;
//     height: 60em;
//     background: url(asset-path('introductions/5.jpg')) no-repeat center center fixed;
//     -ms-background-size: cover;
//     -o-background-size: cover;
//     -moz-background-size: cover;
//     -webkit-background-size: cover;
//     background-size: cover;
// }

//중화질
.introduction{
    position: relative;
    height: 60em;
    background: url(asset-path('introductions/1_2.jpg')) no-repeat center center fixed;
    -ms-background-size: cover;
    -o-background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
    background-size: cover;
}
.alumnus{
    position: relative;
    height: 60em;
    background: url(asset-path('introductions/2_2.jpg')) no-repeat center center fixed;
    -ms-background-size: cover;
    -o-background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
    background-size: cover;
}
.graduate{
    position: relative;
    height: 60em;
    background: url(asset-path('introductions/3_2.png')) no-repeat center center fixed;
    -ms-background-size: cover;
    -o-background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
    background-size: cover;
}
.council{
    position: relative;
    height: 60em;
    background: url(asset-path('introductions/4_2.jpg')) no-repeat center center fixed;
    -ms-background-size: cover;
    -o-background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
    background-size: cover;
}
.hobby{
    position: relative;
    height: 60em;
    background: url(asset-path('introductions/5_2.jpg')) no-repeat center center fixed;
    -ms-background-size: cover;
    -o-background-size: cover;
    -moz-background-size: cover;
    -webkit-background-size: cover;
    background-size: cover;
}

//여기서부터 template css
body{
    overflow-x:hidden;
    font-family:'Roboto Slab','Helvetica Neue',Helvetica,Arial,sans-serif
}
p{
    line-height:1.75
}
a{
    color:#fed136
}
a:hover{
    color:#fec503
}
.text-primary{
    color:#fed136!important
}
h1,h2,h3,h4,h5,h6{
    font-weight:700;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
section{
    padding:100px 0
}
section h2.section-heading{
    font-size:40px;
    margin-top:0;
    margin-bottom:15px
}
section h3.section-subheading{
    font-size:16px;
    font-weight:400;
    font-style:italic;
    margin-bottom:75px;
    text-transform:none;
    font-family:'Droid Serif','Helvetica Neue',Helvetica,Arial,sans-serif
}
@media (min-width:768px){
    section{
        padding:150px 0
    }
}
.btn{
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif;
    font-weight:700
}
.btn-xl{
    font-size:18px;
    padding:20px 40px
}
.btn-primary{
    background-color:#fed136;
    border-color:#fed136
}
.btn-primary:active,.btn-primary:focus,.btn-primary:hover{
    background-color:#fec810!important;
    border-color:#fec810!important;
    color:#fff
}
.btn-primary:active,.btn-primary:focus{
    box-shadow:0 0 0 .2rem rgba(254,209,55,.5)!important
}
::-moz-selection{
    background:#fed136;
    text-shadow:none
}
::selection{
    background:#fed136;
    text-shadow:none
}
img::selection{
    background:0 0
}
img::-moz-selection{
    background:0 0
}
#mainNav{
    background-color:#212529
}
#mainNav .navbar-toggler{
    font-size:12px;
    right:0;
    padding:13px;
    text-transform:uppercase;
    color:#fff;
    border:0;
    background-color:#fed136;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
#mainNav .navbar-brand{
    color:#fed136;
    font-family:'Kaushan Script','Helvetica Neue',Helvetica,Arial,cursive
}
#mainNav .navbar-brand.active,#mainNav .navbar-brand:active,#mainNav .navbar-brand:focus,#mainNav .navbar-brand:hover{
    color:#fec503
}
#mainNav .navbar-nav .nav-item .nav-link{
    font-size:90%;
    font-weight:400;
    padding:.75em 0;
    letter-spacing:1px;
    color:#fff;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
#mainNav .navbar-nav .nav-item .nav-link.active,#mainNav .navbar-nav .nav-item .nav-link:hover{
    color:#fed136
}
@media (min-width:992px){
    #mainNav{
        padding-top:25px;
        padding-bottom:25px;
        -webkit-transition:padding-top .3s,padding-bottom .3s;
        -moz-transition:padding-top .3s,padding-bottom .3s;
        transition:padding-top .3s,padding-bottom .3s;
        border:none;
        background-color:transparent
    }
    #mainNav .navbar-brand{
        font-size:1.75em;
        -webkit-transition:all .3s;
        -moz-transition:all .3s;
        transition:all .3s
    }
    #mainNav .navbar-nav .nav-item .nav-link{
        padding:1.1em 1em!important
    }
    #mainNav.navbar-shrink{
        padding-top:0;
        padding-bottom:0;
        background-color:#212529
    }
    #mainNav.navbar-shrink .navbar-brand{
        font-size:1.25em;
        padding:12px 0
    }
}
header.masthead{
    text-align:center;
    color:#fff;
    background: url(asset-path('introductions/1_2.jpg')) no-repeat center center;
    background-attachment:scroll;
    -webkit-background-size:cover;
    -moz-background-size:cover;
    -o-background-size:cover;
    background-size:cover
}
header.masthead .intro-text{
    padding-top:100px;
    padding-bottom:100px
}
header.masthead .intro-text .intro-lead-in{
    font-size:22px;
    font-style:italic;
    line-height:22px;
    margin-bottom:25px;
    font-family:'Droid Serif','Helvetica Neue',Helvetica,Arial,sans-serif
}
header.masthead .intro-text .intro-heading{
    font-size:50px;
    font-weight:700;
    line-height:50px;
    margin-bottom:25px;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
@media (min-width:768px){
    header.masthead .intro-text{
        padding-top:200px;
        padding-bottom:200px
    }
    header.masthead .intro-text .intro-lead-in{
        font-size:40px;
        font-style:italic;
        line-height:40px;
        margin-bottom:25px;
        font-family:'Droid Serif','Helvetica Neue',Helvetica,Arial,sans-serif
    }
    header.masthead .intro-text .intro-heading{
        font-size:75px;
        font-weight:700;
        line-height:75px;
        margin-bottom:50px;
        font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
    }
}
.service-heading{
    margin:15px 0;
    text-transform:none
}
#portfolio .portfolio-item{
    right:0;
    margin:0 0 15px
}
#portfolio .portfolio-item .portfolio-link{
    position:relative;
    display:block;
    max-width:400px;
    margin:0 auto;
    cursor:pointer
}
#portfolio .portfolio-item .portfolio-link .portfolio-hover{
    position:absolute;
    width:100%;
    height:100%;
    -webkit-transition:all ease .5s;
    -moz-transition:all ease .5s;
    transition:all ease .5s;
    opacity:0;
    background:rgba(254,209,54,.9)
}
#portfolio .portfolio-item .portfolio-link .portfolio-hover:hover{
    opacity:1
}
#portfolio .portfolio-item .portfolio-link .portfolio-hover .portfolio-hover-content{
    font-size:20px;
    position:absolute;
    top:50%;
    width:100%;
    height:20px;
    margin-top:-12px;
    text-align:center;
    color:#fff
}
#portfolio .portfolio-item .portfolio-link .portfolio-hover .portfolio-hover-content i{
    margin-top:-12px
}
#portfolio .portfolio-item .portfolio-link .portfolio-hover .portfolio-hover-content h3,#portfolio .portfolio-item .portfolio-link .portfolio-hover .portfolio-hover-content h4{
    margin:0
}
#portfolio .portfolio-item .portfolio-caption{
    max-width:400px;
    margin:0 auto;
    padding:25px;
    text-align:center;
    background-color:#fff
}
#portfolio .portfolio-item .portfolio-caption h4{
    margin:0;
    text-transform:none
}
#portfolio .portfolio-item .portfolio-caption p{
    font-size:16px;
    font-style:italic;
    margin:0;
    font-family:'Droid Serif','Helvetica Neue',Helvetica,Arial,sans-serif
}
#portfolio *{
    z-index:2
}
@media (min-width:767px){
    #portfolio .portfolio-item{
        margin:0 0 30px
    }
}
.portfolio-modal{
    padding-right:0!important
}
.portfolio-modal .modal-dialog{
    margin:1rem;
    max-width:100vw
}
.portfolio-modal .modal-content{
    padding:100px 0;
    text-align:center
}
.portfolio-modal .modal-content h2{
    font-size:3em;
    margin-bottom:15px
}
.portfolio-modal .modal-content p{
    margin-bottom:30px
}
.portfolio-modal .modal-content p.item-intro{
    font-size:16px;
    font-style:italic;
    margin:20px 0 30px;
    font-family:'Droid Serif','Helvetica Neue',Helvetica,Arial,sans-serif
}
.portfolio-modal .modal-content ul.list-inline{
    margin-top:0;
    margin-bottom:30px
}
.portfolio-modal .modal-content img{
    margin-bottom:30px
}
.portfolio-modal .modal-content button{
    cursor:pointer
}
.portfolio-modal .close-modal{
    position:absolute;
    top:25px;
    right:25px;
    width:75px;
    height:75px;
    cursor:pointer;
    background-color:transparent
}
.portfolio-modal .close-modal:hover{
    opacity:.3
}
.portfolio-modal .close-modal .lr{
    z-index:1051;
    width:1px;
    height:75px;
    margin-left:35px;
    -webkit-transform:rotate(45deg);
    -ms-transform:rotate(45deg);
    transform:rotate(45deg);
    background-color:#212529
}
.portfolio-modal .close-modal .lr .rl{
    z-index:1052;
    width:1px;
    height:75px;
    -webkit-transform:rotate(90deg);
    -ms-transform:rotate(90deg);
    transform:rotate(90deg);
    background-color:#212529
}
.timeline{
    position:relative;
    padding:0;
    list-style:none
}
.timeline:before{
    position:absolute;
    top:0;
    bottom:0;
    left:40px;
    width:2px;
    margin-left:-1.5px;
    content:'';
    background-color:#e9ecef
}
.timeline>li{
    position:relative;
    min-height:50px;
    margin-bottom:50px
}
.timeline>li:after,.timeline>li:before{
    display:table;
    content:' '
}
.timeline>li:after{
    clear:both
}
.timeline>li .timeline-panel{
    position:relative;
    float:right;
    width:100%;
    padding:0 20px 0 100px;
    text-align:left
}
.timeline>li .timeline-panel:before{
    right:auto;
    left:-15px;
    border-right-width:15px;
    border-left-width:0
}
.timeline>li .timeline-panel:after{
    right:auto;
    left:-14px;
    border-right-width:14px;
    border-left-width:0
}
.timeline>li .timeline-image{
    position:absolute;
    z-index:100;
    left:0;
    width:80px;
    height:80px;
    margin-left:0;
    text-align:center;
    color:#fff;
    border:7px solid #e9ecef;
    border-radius:100%;
    background-color:#ffd654
}
.timeline>li .timeline-image h4{
    font-size:10px;
    line-height:14px;
    margin-top:12px
}
.timeline>li.timeline-inverted>.timeline-panel{
    float:right;
    padding:0 20px 0 100px;
    text-align:left
}
.timeline>li.timeline-inverted>.timeline-panel:before{
    right:auto;
    left:-15px;
    border-right-width:15px;
    border-left-width:0
}
.timeline>li.timeline-inverted>.timeline-panel:after{
    right:auto;
    left:-14px;
    border-right-width:14px;
    border-left-width:0
}
.timeline>li:last-child{
    margin-bottom:0
}
.timeline .timeline-heading h4{
    margin-top:0;
    color:inherit
}
.timeline .timeline-heading h4.subheading{
    text-transform:none
}
.timeline .timeline-body>p,.timeline .timeline-body>ul{
    margin-bottom:0
}
@media (min-width:768px){
    .timeline:before{
        left:50%
    }
    .timeline>li{
        min-height:100px;
        margin-bottom:100px
    }
    .timeline>li .timeline-panel{
        float:left;
        width:41%;
        padding:0 20px 20px 30px;
        text-align:right
    }
    .timeline>li .timeline-image{
        left:50%;
        width:100px;
        height:100px;
        margin-left:-50px
    }
    .timeline>li .timeline-image h4{
        font-size:13px;
        line-height:18px;
        margin-top:16px
    }
    .timeline>li.timeline-inverted>.timeline-panel{
        float:right;
        padding:0 30px 20px 20px;
        text-align:left
    }
}
@media (min-width:992px){
    .timeline>li{
        min-height:150px
    }
    .timeline>li .timeline-panel{
        padding:0 20px 20px
    }
    .timeline>li .timeline-image{
        width:150px;
        height:150px;
        margin-left:-75px
    }
    .timeline>li .timeline-image h4{
        font-size:18px;
        line-height:26px;
        margin-top:30px
    }
    .timeline>li.timeline-inverted>.timeline-panel{
        padding:0 20px 20px
    }
}
@media (min-width:1200px){
    .timeline>li{
        min-height:170px
    }
    .timeline>li .timeline-panel{
        padding:0 20px 20px 100px
    }
    .timeline>li .timeline-image{
        width:170px;
        height:170px;
        margin-left:-85px
    }
    .timeline>li .timeline-image h4{
        margin-top:40px
    }
    .timeline>li.timeline-inverted>.timeline-panel{
        padding:0 100px 20px 20px
    }
}
.team-member{
    margin-bottom:50px;
    text-align:center
}
.team-member img{
    width:225px;
    height:225px;
    border:7px solid #fff
}
.team-member h4{
    margin-top:25px;
    margin-bottom:0;
    text-transform:none
}
.team-member p{
    margin-top:0
}
section#contact{
    background-color:#212529;
    background-image:url(../img/map-image.png);
    background-repeat:no-repeat;
    background-position:center
}
section#contact .section-heading{
    color:#fff
}
section#contact .form-group{
    margin-bottom:25px
}
section#contact .form-group input,section#contact .form-group textarea{
    padding:20px
}
section#contact .form-group input.form-control{
    height:auto
}
section#contact .form-group textarea.form-control{
    height:248px
}
section#contact .form-control:focus{
    border-color:#fed136;
    box-shadow:none
}
section#contact ::-webkit-input-placeholder{
    font-weight:700;
    color:#ced4da;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
section#contact :-moz-placeholder{
    font-weight:700;
    color:#ced4da;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
section#contact ::-moz-placeholder{
    font-weight:700;
    color:#ced4da;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
section#contact :-ms-input-placeholder{
    font-weight:700;
    color:#ced4da;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
footer{
    padding:25px 0;
    text-align:center
}
footer span.copyright{
    font-size:90%;
    line-height:40px;
    text-transform:none;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
footer ul.quicklinks{
    font-size:90%;
    line-height:40px;
    margin-bottom:0;
    text-transform:none;
    font-family:Montserrat,'Helvetica Neue',Helvetica,Arial,sans-serif
}
ul.social-buttons{
    margin-bottom:0
}
ul.social-buttons li a{
    font-size:20px;
    line-height:40px;
    display:block;
    width:40px;
    height:40px;
    -webkit-transition:all .3s;
    -moz-transition:all .3s;
    transition:all .3s;
    color:#fff;
    border-radius:100%;
    outline:0;
    background-color:#212529
}
ul.social-buttons li a:active,ul.social-buttons li a:focus,ul.social-buttons li a:hover{
    background-color:#fed136
}
```

### 이미지   
###### app/assets/images/introductions
###### app/assets/images/notices
###### public/clubs
###### public/councils
###### public/medicine2.png

### 폰트
###### app/assets/stylesheets/fonts

Notice, Handout, Card
---------------------
### MVC 설정
###### 모델
>$ rails g model Notice title:string content:text user:belongs_to  
>$ rails g model Handout title:string content:text user:belongs_to file:string  
>$ rails g model Card title:string content:text user:belongs_to image:string  
>$ rails g model Nreply content:text user:belongs_to notice:belongs_to  
>$ rails g model Hreply content:text user:belongs_to handout:belongs_to  
>$ rails g model Creply content:text user:belongs_to card:belongs_to 

###### 컨트롤러
>$ rails g controller Notices index show new edit  
>$ rails g controller Handouts index show new edit  
>$ rails g controller Cards index show new edit  
>$ rails g controller Nreply create destroy  
>$ rails g controller Hreply create destroy  
>$ rails g controller Creply create destroy  
>내용 채우자

###### 뷰
>내용 채우자  

###### 라우팅
```
Rails.application.routes.draw do
  resources :cards do
    resources :creplies, only: [:create, :destroy]
  end
  resources :handouts do
    resources :hreplies, only: [:create, :destroy]
  end
  resources :notices do
    resources :nreplies, only: [:create, :destroy]
  end
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks' }
  get '/introductions/user_information', to: 'introductions#user_information', as: 'user_information'
  root 'introductions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

###### 업로더
>$ rails generate uploader File  
>$ rails generate uploader image  
>$ rails generate uploader proimg  
>내용 수정  

###### Imagemagick 추가하자
>$ sudo yum update  
>$ sudo yum install ImageMagick  


### AWS setting
###### config/initializers/carrierwave.rb

```
require 'carrierwave/orm/activerecord'
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
  provider: 'AWS', # required
  aws_access_key_id: ENV['AWS_KEY'], # required
  aws_secret_access_key: ENV['AWS_SECRET'], # required
  region: ' ap-southeast-1 ', # optional, defaults to 'us-east-1'
  }
  config.fog_directory = 'name_of_directory' # required
end
```

