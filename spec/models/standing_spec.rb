describe Standing do
  describe ".current" do
    it "retrieves current standings" do
      VCR.use_cassette("current_standings") do
        expect(Standing.current.to_a.size).to eq(18)
      end
    end

    it "returns Standing objects" do
      VCR.use_cassette("current_standings") do
        leader = Standing.current.first
        expect(leader.position).to eq(1)
        expect(leader.points).to eq(25)
        expect(leader.driver_name).to eq("Lewis Hamilton")
      end
    end
  end
end
