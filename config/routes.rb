Rails.application.routes.draw do
  resource :feed, only: :show
end
