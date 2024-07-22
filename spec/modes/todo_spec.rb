
require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'バリデーションのテスト' do
    let!(:todo) { build(:todo) }
    subject { todo.valid? }


    context 'titleカラム' do
      it '空欄でないこと' do
        todo.title = ''
        is_expected.to eq false;
      end
    end
  end

end
