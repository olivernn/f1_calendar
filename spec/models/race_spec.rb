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

  describe "#grid_positions" do
    let(:params) do
      {
        id: "2015/1",
        name: "name",
        number: 1,
        season: "2015",
        url: URI("http://example.com"),
        circuit: :circuit,
      }
    end

    context "race in the past" do
      let(:race) { Race.new(params.merge(starts_at: Date.yesterday.to_time)) }

      it "returns all results" do
        VCR.use_cassette("race_grid_positions") do
          grid_positions = race.grid_positions.to_a

          expect(grid_positions.size).to eq(18)

          pole = grid_positions.first

          expect(pole.driver_name).to eq("Lewis Hamilton")
          expect(pole.position).to eq(1)
        end
      end
    end

    context "race is today" do
      let(:race) { Race.new(params.merge(starts_at: Time.now)) }

      it "returns all results" do
        VCR.use_cassette("race_grid_positions") do
          grid_positions = race.grid_positions.to_a

          expect(grid_positions.size).to eq(18)

          pole = grid_positions.first

          expect(pole.driver_name).to eq("Lewis Hamilton")
          expect(pole.position).to eq(1)
        end
      end
    end

    context "race is in the future" do
      let(:race) { Race.new(params.merge(starts_at: Date.tomorrow.to_time)) }

      it "returns no races" do
        expect(race.grid_positions).to be_empty
      end
    end
  end

  describe "#results" do
    let(:params) do
      {
        id: "2015/1",
        name: "name",
        number: 1,
        season: "2015",
        url: URI("http://example.com"),
        circuit: :circuit,
      }
    end

    context "race in the past" do
      let(:race) { Race.new(params.merge(starts_at: Date.yesterday)) }

      it "returns all results" do
        VCR.use_cassette("race_results") do
          results = race.results.to_a

          expect(results.size).to eq(18)

          winner = results.first

          expect(winner.driver_name).to eq("Lewis Hamilton")
          expect(winner.position).to eq(1)
        end
      end
    end

    context "race is in the future" do
      let(:race) { Race.new(params.merge(starts_at: Date.tomorrow)) }

      it "returns no races" do
        expect(race.results).to be_empty
      end
    end
  end

  describe "#past?" do
    let(:params) do
      {
        id: "2015/1",
        name: "name",
        number: 1,
        season: "2015",
        url: URI("http://example.com"),
        circuit: :circuit
      }
    end

    context "race in the past" do
      let(:race) do
        Race.new(params.merge(starts_at: Date.yesterday))
      end

      it "is in the past" do
        expect(race).to be_past
      end
    end

    context "race in the future" do
      let(:race) do
        Race.new(params.merge(starts_at: Date.tomorrow))
      end

      it "is in the past" do
        expect(race).not_to be_past
      end
    end
  end
end
