require_relative 'spec_helper'
require_relative 'model'

describe ActsAsArray do
  after do
    User.delete_all
    Mail.delete_all
    Phone.delete_all
  end
  let(:user) { User.new(name: 'test') }
  let(:raw_mails) { ['a@a.com', 'b@b.com'] }

  context '#make_fields' do
    let(:subject) { user.make_mails(raw_mails) }
    it 'should convert raw fields to obj fields' do
      expect(subject.map(&:name)).to eql(raw_mails)
      expect(Mail.all.size).to eql(0)
    end
  end

  context '#fields=' do
    before { user.mails = raw_mails }
    it 'should set raw fields as obj fields' do
      expect(user.obj_mails.map(&:name)).to eql(raw_mails)
      expect(Mail.all.size).to eql(0)
    end

    it 'should create objects with #save' do
      user.save
      expect(Mail.all.size).to eql(2)
    end

    it 'should not create already existing objects' do
      user.save
      user.mails = raw_mails
      expect(Mail.all.size).to eql(2)
    end
  end

  context '#fields' do
    before { user.mails = raw_mails }
    it 'should return raw fields' do
      expect(user.mails).to eql(raw_mails)
    end
  end

  context '#obj_fields' do
    before { user.mails = raw_mails }
    it 'should return obj fields' do
      expect(user.obj_mails.map(&:name)).to eql(raw_mails)
    end
  end

  context '#update_attributes' do
    it 'should update_attributes with raw fields' do
      user.update_attributes(mails: raw_mails)
      expect(user.obj_mails.map(&:name)).to eql(raw_mails)
      expect(Mail.all.size).to eql(2)
    end
  end

  context '#update' do
    it 'should update with raw fields' do
      user.update(mails: raw_mails)
      expect(user.obj_mails.map(&:name)).to eql(raw_mails)
      expect(Mail.all.size).to eql(2)
    end
  end

  context '.create' do
    let(:user) { User.create(name: 'test', mails: raw_mails) }
    it { expect(user.obj_mails.map(&:name)).to eql(raw_mails) }
  end
end

