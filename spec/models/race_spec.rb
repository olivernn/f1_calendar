require 'rails_helper'

describe Race do
  describe ".all" do
    it "fetches all races" do
      VCR.use_cassette("all_races") do
        expect(Race.all.to_a.size).to eq(19)
      end
    end

    context "parsing response" do
      let(:race) { Race.all.first }
      let(:circuit) { race.circuit }

      it "fetches race attributes" do
        VCR.use_cassette("all_races") do
          expect(race.id).to eq("2015/1")
          expect(race.number).to eq(1)
          expect(race.season).to eq("2015")
        end
      end

      it "fetches circuit attributes" do
        VCR.use_cassette("all_races") do
          expect(circuit.country).to eq("Australia")
          expect(circuit.locality).to eq("Melbourne")
        end
      end
    end
  end
end
