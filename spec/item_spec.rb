require 'rails_helper'

RSpec.describe Item, type: :model do
    let(:item) { create(:item) }

    describe '#soft_delete' do
        it 'soft deletes an item' do
            item.soft_delete
            expect(item.deleted_at).not_to be_nil
        end
    end

    describe '#restore' do
        it 'restores a soft-deleted item' do
            item.soft_delete
            item.restore
            expect(item.deleted_at).to be_nil
        end
    end

    describe 'default scope' do
        it 'excludes soft-deleted items from normal queries' do
            soft_deleted_item = create(:item)
            soft_deleted_item.soft_delete
            expect(Item.all).not_to include(soft_deleted_item)
        end
    end
end