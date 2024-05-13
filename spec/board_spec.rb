# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  describe '#move' do
    context 'When moving a piece' do
      let(:test_piece) { double('piece') }
      before do
        board.instance_variable_get(:@board)[0][0] = test_piece
        allow(test_piece).to receive(:update_position)
        allow(test_piece).to receive(:is_a?).and_return(true)
        allow(test_piece).to receive(:moved)
      end
      it 'Removes piece from old position' do
        expect { board.move([0, 0], [1, 1]) }.to change { board.instance_variable_get(:@board)[0][0] }.to(nil)
      end
      it 'Moves piece to new position' do
        expect { board.move([0, 0], [1, 1]) }.to change { board.instance_variable_get(:@board)[1][1] }.to(test_piece)
      end
      it 'Calls update_position with new position once' do
        expect(test_piece).to receive(:update_position).with([1, 1]).once
        board.move([0, 0], [1, 1])
      end
      it 'Calls moved on Pawn once if piece moved is a Pawn' do
        expect(test_piece).to receive(:moved).once
        board.move([0, 0], [1, 1])
      end
    end
  end
end
