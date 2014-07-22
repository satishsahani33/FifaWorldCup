CommissionOperatorSummaryByDay.select("operators.username as commission_operator,
               SUM(total_sales_qty - total_returns_qty) as net_units_sold,
               SUM(total_tax_ex_sales_value - total_tax_ex_returns_value) as net_sales").
             joins("INNER JOIN operators ON operators.id = commission_operator_summary_by_days.operator_id").
          where("transaction_date >= ?", start_date).
          where("transaction_date <= ?", end_date).
          where("business_unit_id=?", business_unit.id).
          group("operators.id").
          order("operators.username desc")
#use this query
Match.select("matches.id, matches.team_a, matches.team_b, p.predict_score_a, p.predict_score_b").
	joins("INNER JOIN predictions p ON p.match_id = matches.id").
	where("p.user_id = ?", '2')


  Match.select("matches.team_a, matches.team_b, p.predict_score_a, p.predict_score_b").
  joins("INNER JOIN predictions p ON p.match_id = matches.id").
  where("p.user_id = ?", '2')


  Match.select("matches.team_a, matches.team_b, p.predict_score_a, p.predict_score_b").
  joins("LEFT JOIN predictions p ON 1=1").
  where("p.user_id = ?", '2')


  Match.select("matches.team_a, matches.team_b, p.predict_score_a, p.predict_score_b").
  joins("LEFT JOIN predictions p ON p.match_id = matches.id AND p.user_id = #{session[:user]}")

  Category.select("categories.*, posts.*").joins(:posts)


  Match.select("matches.*, predictions.*").joins(:predictions)