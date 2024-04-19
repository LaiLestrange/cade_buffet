require 'rails_helper'

describe "BuffetAdmin register Buffet" do
  context "correct behaviour" do
    it "right after registering their new account" do
      #arrange
      buffet_admin = BuffetAdmin.new(
        name: "Administrador do Buffet",
        email: "buffet@admin.com",
        password: "04dm1n"
      )

      #act
      visit root_path
      within 'header'  do
        click_on 'Entrar'
      end
      click_on 'Criar uma conta'
      within 'form' do
        fill_in 'Nome', with: buffet_admin.name
        fill_in 'E-mail', with: buffet_admin.email
        fill_in 'Senha', with: buffet_admin.password
        fill_in 'Confirme sua senha', with: buffet_admin.password
        click_on 'Criar conta'
      end

      #assert
      expect(current_path).to eq new_buffet_path
      expect(page).to have_button "Sair"
      expect(page).to have_content "Cadastro de Buffet"
      within('#new_buffet') do
        expect(page).to have_field 'Nome Fantasia'
        expect(page).to have_field 'Descrição'
        expect(page).to have_field 'Nome de Registro'
        expect(page).to have_field 'CNPJ'
        expect(page).to have_field 'Telefone'
        expect(page).to have_field 'E-mail'
        expect(page).to have_field 'Endereço'
        expect(page).to have_field 'Estado'
        expect(page).to have_field 'Cidade'
        expect(page).to have_field 'CEP'
        expect(page).to have_button 'Criar Buffet'
      end
    end

    it 'and does it successfully' do
      #arrange
      buffet_admin = BuffetAdmin.create!(
        name: "Administrador do Buffet",
        email: "buffet@admin.com",
        password: "04dm1n"
      )
      login_as(buffet_admin, scope: :buffet_admin)
      #act
      visit root_path
      within('#new_buffet') do
        fill_in 'Nome Fantasia', with: 'Eventos Buffet'
        fill_in 'Descrição', with: 'Um buffet que provê serviços de eventos'
        fill_in 'Nome de Registro', with: 'Buffet de Eventos LTDA'
        fill_in 'CNPJ', with: '333-456'
        fill_in 'Telefone', with: '11 2222-3333'
        fill_in 'E-mail', with: 'eventos@buffet.com'
        fill_in 'Endereço', with: 'Rua dos Eventos, 12'
        fill_in 'Estado', with: 'EV'
        fill_in 'Cidade', with: 'Eventualidade'
        fill_in 'CEP', with: '34567-891'
        click_on 'Criar Buffet'
      end

      #assert
      expect(current_path).to eq buffets_path
      expect(page).to have_content 'TEM QUE CHEGAR AQUI'
    end

    #and has access to other routes
  end


  context "wrong behaviour" do
    #tries other routes before registering the buffet
    #tries to fill out with missing information
    #tries to register a second buffet
  end
end


# se o buffet_admin nao tiver um buffet ja cadastrado, mandar pra uma tela de cadastro
# a unica opção dele deve ser: ou cadastrar o buffet, ou logout
# se tentar usar outras rotas sem essa validação (buffet cadastrado) volta para a mesma tela de cadastro

#cadastrar o buffet com o buffet.buffet_admin_id = current_user.id
#validar com o uniqueness

#redirecionar sempre para root
#em root (application.html.erb), fazer a verificação
  # verificação: Buffet.find(buffet_admin_id).any?
#exibir um bloco de cadastro caso false (bloco específico)
#exibir a aplicação normal caso true (yield)
