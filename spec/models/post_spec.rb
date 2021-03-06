require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) {FactoryBot.create(:user)}
  describe 'バリデーションのテスト' do
    context 'ポストの内容が空の場合' do
      it 'バリデーションに引っかかる' do
        post = Post.new(content: '')
        expect(post).not_to be_valid
      end
    end
    context 'ポストの内容が1000文字以上の場合' do
      it 'バリデーションに引っかかる' do
        post = Post.new(content: 'a'* 1001)
        expect(post).not_to be_valid
      end
    end
    context 'ポストの内容を1000字以内で入力した場合' do
      it 'バリデーションが通る' do
        post = Post.new(content: '成功テスト', user: user)
        expect(post).to be_valid
      end
    end
  end
  describe 'アソシエーションテスト' do
    let!(:post) {FactoryBot.create(:post, user_id: user.id)}
    let!(:favorite) {FactoryBot.create(:favorite, user: user, post: post)}
    context 'ポストが削除されたとき' do
      it '該当ポストのfavoriteデータも削除される' do
        expect { post.destroy }.to change { Favorite.count}.by(-1)
      end
    end
  end
end