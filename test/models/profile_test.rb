require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
    test "add_partner invalid key" do
        setup
        res = @profile1.add_partner("blahblah")
        assert res == "Partner Key not valid"
    end

    test "add_partner success" do
        setup
        @profile1.add_partner(@profile2.key)
        res = @profile2.add_partner(@profile1.key)
        assert res == "You and your partner are now connected!"
    end

    test "add_partner need partner to add back" do
        setup
        res = @profile1.add_partner(@profile2.key)
        assert res == "Cannot send messages until partner adds you back"
    end

    test "remove_oldest_message one message" do
        connect(@profile1, @profile2)
        m = Message.create(text: "test", profile_id: @profile1.id, 
                           sender_id: @profile2.id)
        res = @profile1.remove_oldest_message
        assert res == m.text
    end

    test "remove_oldest_message zero message" do
        connect(@profile1, @profile2)
        res = @profile1.remove_oldest_message
        assert res == ""
    end

    test "remove_oldest_message more than one message" do
        connect(@profile1, @profile2)
        m = Message.create(text: "test", profile_id: @profile1.id, 
                           sender_id: @profile2.id)
        m2 = Message.create(text: "test2", profile_id: @profile1.id, 
                           sender_id: @profile2.id)
        res = @profile1.remove_oldest_message
        assert res == m.text

        res = @profile1.remove_oldest_message
        assert res == m2.text
    end

    private
    def setup
        @profile1 = Profile.create(name: "P1", email: "1@gmail.com")
        @profile1.update_attribute(:key, @profile1.hash)

        @profile2 = Profile.create(name: "P2", email: "2@gmail.com")
        @profile2.update_attribute(:key, @profile2.hash)
    end

    def connect(p1,p2)
        p1.add_partner(p2.key)
        p2.add_partner(p1.key)
    end
end
