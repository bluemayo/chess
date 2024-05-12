# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  describe '#init_pieces' do
    context 'When creating new Board' do
      let(:test_rook) { double('rook') }
      let(:test_knight) { double('knight') }
      let(:test_bishop) { double('bishop') }
      let(:test_queen) { double('queen') }
      let(:test_king) { double('king') }
      let(:test_pawn) { double('pawn') }
      before do
        allow(Pieces::Rook).to receive(:new).and_return(test_rook)
        allow(Pieces::Knight).to receive(:new).and_return(test_knight)
        allow(Pieces::Bishop).to receive(:new).and_return(test_bishop)
        allow(Pieces::Queen).to receive(:new).and_return(test_queen)
        allow(Pieces::King).to receive(:new).and_return(test_king)
        allow(Pieces::Pawn).to receive(:new).and_return(test_pawn)
      end
      context 'Initializes all pieces to starting position' do
        let(:correct) { [test_rook, test_knight, test_bishop, test_queen, test_king, test_bishop,test_knight,test_rook] }
        it 'Row 0 is ordered correctly' do
          game.init_pieces
          expect([game.instance_variable_get(:@board).instance_variable_get(:@board)[0]]).to contain_exactly(correct)
        end
        it 'Row 1 only contain Pawns' do
          game.init_pieces
          expect(game.instance_variable_get(:@board).instance_variable_get(:@board)[1].all?(test_pawn)).to eql(true)
        end
        it 'Rows 2 is empty' do
          game.init_pieces
          expect(game.instance_variable_get(:@board).instance_variable_get(:@board)[2].all?(nil)).to eql(true)
        end
        it 'Rows 3 is empty' do
          game.init_pieces
          expect(game.instance_variable_get(:@board).instance_variable_get(:@board)[3].all?(nil)).to eql(true)
        end
        it 'Rows 4 is empty' do
          game.init_pieces
          expect(game.instance_variable_get(:@board).instance_variable_get(:@board)[4].all?(nil)).to eql(true)
        end
        it 'Rows 5 is empty' do
          game.init_pieces
          expect(game.instance_variable_get(:@board).instance_variable_get(:@board)[5].all?(nil)).to eql(true)
        end
        it 'Row 6 only contain Pawns' do
          game.init_pieces
          expect(game.instance_variable_get(:@board).instance_variable_get(:@board)[6].all?(test_pawn)).to eql(true)
        end
        it 'Row 7 is ordered correctly' do
          game.init_pieces
          expect([game.instance_variable_get(:@board).instance_variable_get(:@board)[7]]).to contain_exactly(correct)
        end
      end
    end
  end
end
