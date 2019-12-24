# frozen_string_literal: true

module Mitake
  # The message status
  #
  # @since 0.1.0
  module Status
    # @since 0.1.0
    CODES = {
      0 => '預約傳送中',
      1 => '已送達業者',
      2 => '已送達業者',
      4 => '已送達手機',
      5 => '內容有錯誤',
      6 => '門號有錯誤',
      7 => '簡訊已停用',
      8 => '逾時無送達',
      9 => '預約已取消'
    }.freeze
  end
end
