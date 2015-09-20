require_relative '../lib/game'

describe Game do
  let(:game) { Game.new }

  describe "#move_piece" do
    it "moves to and from the correct positions" do
      comparison_piece = game.board[6][Game::LETTERS_TO_INDEX['A']]
      game.move_piece("6A", "5A")
      expect(game.board[6][Game::LETTERS_TO_INDEX['A']]).to eq('-')
      expect(game.board[5][Game::LETTERS_TO_INDEX['A']]).to eq(comparison_piece)
    end
    it "does nothing if there is no piece at the desired square" do
      expect(game.move_piece("4A", "3A")).to be_falsey
    end
  end
  describe "#out_of_bounds" do
    it "does not move out of bounds" do
      expect(game.out_of_bounds("6A", "8A")).to be_truthy
      expect(game.out_of_bounds("6A", "6I")).to be_truthy
      expect(game.out_of_bounds("6A", "5A")).to be_falsey
    end
  end

  describe "#get_piece_at" do
    it "returns the name of the correct piece" do
      game.move_piece("6A", "5A")
      expect(game.get_piece_at("6A")).to eq("-")
      expect(game.get_piece_at("5A")).to eq("PAWN_BLACK")
      expect(game.get_piece_at("7H")).to eq("ROOK_BLACK")
      expect(game.get_piece_at("0E")).to eq("QUEEN_WHITE")
    end
  end
  describe "#switch_player" do
    it "switches player correctly" do
      expect(game.cur_player).to eq(:one)
      game.switch_player
      expect(game.cur_player).to eq(:two)
    end
  end
  describe "#valid_play_for_knight" do
    it "moves to the correct places" do
      game.move_piece("7B", "5C")
      expect(game.valid_play_for_knight("5C", "3D")).to be_truthy
      expect(game.valid_play_for_knight("5C", "3B")).to be_truthy
      expect(game.valid_play_for_knight("5C", "4A")).to be_truthy
      expect(game.valid_play_for_knight("5C", "4E")).to be_truthy
      expect(game.valid_play_for_knight("5C", "6A")).to be_falsey
      expect(game.valid_play_for_knight("5C", "7B")).to be_truthy
      expect(game.valid_play_for_knight("5C", "7D")).to be_falsey
      expect(game.valid_play_for_knight("5C", "6E")).to be_falsey
    end
  end
  describe "#valid_play_for_rook" do
    it "moves to the correct places" do
      game.board[6][0] = '-'
      game.move_piece("7A", "5A")
      expect(game.valid_play_for_rook("5A", "5H")).to be_truthy
      expect(game.valid_play_for_rook("5A", "2A")).to be_truthy
      expect(game.valid_play_for_rook("5A", "1A")).to be_truthy
      expect(game.valid_play_for_rook("5A", "0A")).to be_falsey
      expect(game.valid_play_for_rook("5A", "1B")).to be_falsey
    end
  end
end
