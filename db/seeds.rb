# organization
organization = Organization.create name: 'tester'

# admin
User.create!({ username: 'admin', name: 'admin', active: true, admin: true, group: 'admin', password: 'adminpass123', password_confirmation: 'adminpass123', email: 'admin@test.com', organization: organization }, as: :admin)

# user John
User.create!({ username: 'johny', name: 'John Doe', active: true, group: 'User', password: 'secret', password_confirmation: 'secret', email: 'john@test.com', organization: organization}, as: :admin)

User.create!({ username: 'marry', name: 'Marry Doe', active: false, group: 'User', password: 'secret', password_confirmation: 'secret', email: 'marry@test.com', organization: organization }, as: :admin)


# pay period 2012-03-5 - 2012-03-11
PayPeriod.create!({ pay_start: '2012-03-5', pay_end: '2012-03-11', organization: organization }, as: :admin )

# pay period 2012-03-12 - 2012-03-18
PayPeriod.create!({ pay_start: '2012-03-12', pay_end: '2012-03-18', active: true, organization: organization }, as: :admin )