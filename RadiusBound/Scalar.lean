module

public import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Tactic

public section

namespace RadiusBound

open Real

/-- The exponential envelope dominates twice every natural radius. -/
theorem scalar_bound (r : ℕ) :
    2 * (r : ℝ) ≤ (Real.sqrt 8) ^ Real.sqrt (r : ℝ) := by
  rcases r.eq_zero_or_pos with hr | hr
  · simp [hr]
  have hrpos : 0 < (r : ℝ) := by exact_mod_cast hr
  have logEight : log 8 = 3 * log 2 := by
    rw [show (8 : ℝ) = 2 ^ 3 by norm_num, log_pow]
    norm_num
  have logTwoPos : 0 < log 2 := log_pos (by norm_num)
  apply (log_le_log_iff (by positivity) (rpow_pos_of_pos (by positivity) _)).mp
  rw [log_rpow (by positivity), log_sqrt (by norm_num), logEight,
    log_mul (by norm_num) hrpos.ne']
  by_cases hlarge : 4 ≤ r
  · have hr4 : 4 ≤ (r : ℝ) := by exact_mod_cast hlarge
    have hs : 2 ≤ √(r : ℝ) := le_sqrt_of_sq_le (by linarith)
    have ht := log_le_sub_one_of_pos (show 0 < √(r : ℝ) / 2 by positivity)
    rw [log_div (by positivity) (by norm_num), log_sqrt hrpos.le] at ht
    have hc : 1 ≤ 3 * log 2 / 2 := by linarith [log_two_gt_d9]
    nlinarith only [ht, mul_nonneg (sub_nonneg.mpr hs) (sub_nonneg.mpr hc)]
  · have hr3 : r ≤ 3 := by omega
    interval_cases r
    · simp
      linarith
    · norm_num only [Nat.cast_ofNat]
      have hs : 4 / 3 ≤ √(2 : ℝ) := le_sqrt_of_sq_le (by norm_num)
      nlinarith only [mul_nonneg (sub_nonneg.mpr hs) logTwoPos.le]
    · norm_num only [Nat.cast_ofNat]
      have hs : 19 / 11 ≤ √(3 : ℝ) := le_sqrt_of_sq_le (by norm_num)
      have hp := log_le_log (by positivity : 0 < (3 : ℝ) ^ 22)
        (by norm_num : (3 : ℝ) ^ 22 ≤ 2 ^ 35)
      rw [log_pow, log_pow] at hp
      norm_num only [Nat.cast_ofNat] at hp
      nlinarith only [hp, mul_nonneg (sub_nonneg.mpr hs) logTwoPos.le]

#print axioms scalar_bound

end RadiusBound
