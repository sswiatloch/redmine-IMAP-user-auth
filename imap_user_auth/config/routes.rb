# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
get 'imapuserauth', to: 'imapuserauth#index'
post 'imapuserauth/update', to: 'imapuserauth#updateDatabase'