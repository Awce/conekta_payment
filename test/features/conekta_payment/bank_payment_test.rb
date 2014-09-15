require 'test_helper'

feature 'Bank Payment Test' do
  before do
    visit engine_routes.pay_root_path
  end

  scenario 'sanity' do
    page.must_have_content 'Su orden'
  end

  scenario 'display order info' do
    page.must_have_css '.product-name', text: 'eBook Aprendiendo Ruby on Rails 4.0'
    page.must_have_css '.product-price', text: 'MXN$ 200.00 x 1'
  end

  scenario 'display order details' do
    within('#new_pay') do
      page.must_have_css '#pay_email'
      page.must_have_css '#card_number'
      page.must_have_css '#card_name'
      page.must_have_css '#card_expiry'
      page.must_have_css '#card_cvc'
      page.must_have_css '#pay_action'
    end
  end

  scenario 'display errors on submit when data incomplete' do
    within('#new_pay') do
      click_button 'Pagar MXN$ 200.00'

      page.must_have_css '.error-area'
      page.all('.error').length.must_equal 5
    end
  end
end
