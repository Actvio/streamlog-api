json.array! @users do |user|
  json.(user, :id, :username, :email, :first_name, :