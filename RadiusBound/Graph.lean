module

public import Mathlib.Combinatorics.SimpleGraph.Diam
public import RadiusBound.Scalar

public section

namespace RadiusBound

open SimpleGraph

/-- The usual diameter–radius bound, expressed using natural-valued invariants. -/
theorem diam_le_twice_radius {V : Type*} [Finite V] [Nonempty V]
    (G : SimpleGraph V) (hc : G.Connected) : G.diam ≤ 2 * G.radius.toNat := by
  have hr : G.radius ≠ ⊤ := G.radius_ne_top_iff.mpr hc
  have hmul : 2 * G.radius ≠ ⊤ :=
    (WithTop.mul_lt_top (ENat.natCast_lt_top 2) (lt_top_iff_ne_top.mpr hr)).ne
  simpa [SimpleGraph.diam] using ENat.toNat_le_toNat G.ediam_le_two_mul_radius hmul

/-- On every finite connected graph in the corpus, base √8 suffices. -/
theorem sharp_bound {n : ℕ} (hn : 2 ≤ n) (G : SimpleGraph (Fin n)) (hc : G.Connected) :
    (G.diam : ℝ) ≤ (Real.sqrt 8) ^ Real.sqrt (G.radius.toNat : ℝ) := by
  have : Nonempty (Fin n) := ⟨⟨0, by omega⟩⟩
  calc
    (G.diam : ℝ) ≤ 2 * (G.radius.toNat : ℝ) := by exact_mod_cast diam_le_twice_radius G hc
    _ ≤ _ := scalar_bound _

/-- Duhamel–Cazenave corpus item 956425, retaining its product expression for the base. -/
theorem conjecture_956425 {n : ℕ} (hn : 2 ≤ n) (G : SimpleGraph (Fin n)) (hc : G.Connected) :
    (G.diam : ℝ) ≤ (2 * Real.sqrt 2) ^ Real.sqrt (G.radius.toNat : ℝ) := by
  have hs : Real.sqrt (8 : ℝ) = 2 * Real.sqrt 2 := by
    rw [show (8 : ℝ) = 2 ^ 2 * 2 by norm_num, Real.sqrt_mul (by positivity),
      Real.sqrt_sq (by norm_num)]
  simpa only [hs] using sharp_bound hn G hc

/-- Duhamel–Cazenave corpus item 790683, in the notation of the source CSV. -/
theorem conjecture_790683 {n : ℕ} (hn : 2 ≤ n) (G : SimpleGraph (Fin n)) (hc : G.Connected) :
    (G.diam : ℝ) ≤ (1 + 2 : ℝ) ^ Real.sqrt (G.radius.toNat : ℝ) := by
  apply (sharp_bound hn G hc).trans
  exact Real.rpow_le_rpow (Real.sqrt_nonneg _) (by
    nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 8)]) (Real.sqrt_nonneg _)

end RadiusBound

#print axioms RadiusBound.conjecture_956425
#print axioms RadiusBound.conjecture_790683
