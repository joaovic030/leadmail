Rails.application.routes.draw do
  # get 'lead/receive_message', to: 'lead#receive_message'
  get 'lead/receive_message', to: 'lead#receive_message'
  root to: 'lead#receive_file'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
