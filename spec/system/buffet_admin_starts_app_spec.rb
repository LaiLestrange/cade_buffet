require 'rails_helper'

describe "BuffetAdmin opens the app" do
  it "and is not logged in" do
    #arrange

    #act
    visit root_path

    #assert
    expect(page).to have_content 'Cadê Buffet?'
    within 'header' do
      expect(page).to have_link 'Entrar'
    end
  end

  it 'and logs in' do
    #arrange
    admin = BuffetAdmin.create!(
      name: "Administrador do Buffet",
      email: "buffet@admin.com",
      password: "04dm1n"
    )

    #act
    visit root_path
    within 'header'  do
      click_on 'Entrar'
    end
    fill_in 'E-mail', with: admin.email
    fill_in 'Senha', with: admin.password
    within 'form' do
      click_on 'Entrar'
    end

    #assert
    expect(current_path).to eq root_path
  end

  it 'successfully' do
    #arrange
    admin = BuffetAdmin.create!(
      name: "Ademir do Buffet",
      email: "buffet@adm.com",
      password: "04dm1n"
    )

    login_as admin, scope: :buffet_admin

    #act
    visit root_path

    #assert
    expect(page).to have_content "Olá, #{admin.name}"
    expect(page).to have_button "Sair"

  end

  it 'and logs out successfully' do
    #arrange
    admin = BuffetAdmin.create!(
      name: "Ademir do Buffet",
      email: "buffet@adm.com",
      password: "04dm1n"
    )

    login_as admin, scope: :buffet_admin

    #act
    visit root_path
    within 'header'  do
      click_on 'Sair'
    end

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
  end
end
