class DiceController < ApplicationController
  def index
    allowed_bets = [10, 25, 50, 100]
    @bet = params[:bet].to_i
    @bet = 25 unless allowed_bets.include?(@bet)

    session[:bankroll] = 1000 if session[:bankroll].nil?
    session[:rolls] ||= 0
    session[:wins] ||= 0
    session[:losses] ||= 0
    session[:streak] ||= 0
    session[:best_streak] ||= 0

    @die1 = rand(1..6)
    @die2 = rand(1..6)
    @total = @die1 + @die2

    losing_totals = [2, 7]
    @win = !losing_totals.include?(@total)
    @result = @win ? "Number is #{@total}" : "You Lose"
    @result_class = @win ? "win" : "lose"

    session[:rolls] += 1

    if @win
      session[:wins] += 1
      session[:streak] += 1
      session[:bankroll] += @bet
      session[:best_streak] = [session[:best_streak], session[:streak]].max
    else
      session[:losses] += 1
      session[:streak] = 0
      session[:bankroll] -= @bet
    end

    @bankroll = session[:bankroll]
    @rolls = session[:rolls]
    @wins = session[:wins]
    @losses = session[:losses]
    @streak = session[:streak]
    @best_streak = session[:best_streak]
  end
end
