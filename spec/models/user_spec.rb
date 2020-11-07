require 'rails_helper'

describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまく行く時' do
      it 'nickname,family_name,first_name,email,password,pasword_confirmation,katakana_family_name,katakana_first_name,birthdayが入力されたら登録できる' do
        expect(@user).to be_valid
      end
      it 'family_name, first_nameは全角(漢字、ひらがな、カタカナ)' do
        expect(@user).to be_valid
      end
      it 'katakana_family_name, katakana_first_nameは全角（カタカナ）' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字で登録可能' do
        @user.password = "aiueo777"
        @user.password_confirmation = "aiueo777"
        expect(@user).to be_valid
      end

    end
    context '新規登録がうまくいかない時' do
      it 'nicknameが空の場合' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空の場合' do
        @user.email =""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに@がない場合' do
        @user.email = "sample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it '同じemailが存在する場合' do
        @user.save
        user2 = FactoryBot.build(:user)
        user2.email = @user.email
        user2.valid?
        expect(user2.errors.full_messages).to include("Email has already been taken")
      end

      it 'passwordが空の場合' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが５文字以下の場合' do
        @user.password = "test1"
        @user.password_confirmation = "test1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが半角英数字ではない場合' do
        @user.password ="lettersonly"
        @user.password_confirmation ="lettersonly"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordとpassword_confirmationが違う場合' do
        @user.password_confirmation = "sample1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameが空の場合' do
        @user.family_name =""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid")
      end

      it 'first_nameが空の場合' do
        @user.first_name =""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end

      it 'family_nameが全角(漢字、ひらがな、カタカナ)では無い場合' do
        @user.family_name = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end

      it 'first_nameが全角(漢字、ひらがな、カタカナ)では無い場合' do
        @user.first_name = "aiueo"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'katakana_family_nameが空の場合' do
        @user.katakana_family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana family name can't be blank", "Katakana family name is invalid")
      end

      it 'katakana_first_nameが空の場合' do
        @user.katakana_first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana first name can't be blank", "Katakana first name is invalid")
      end

      it 'katakana_family_nameがカタカナではない場合' do
        @user.katakana_family_name = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana family name is invalid")
      end

      it 'katakana_first_nameがカタカナではない場合' do
        @user.katakana_first_name = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Katakana first name is invalid")
      end

      it '"birthdayが空の場合' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

  end
end

