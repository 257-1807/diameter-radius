module

public import Mathlib.Combinatorics.SimpleGraph.Hasse
public import RadiusBound.Graph

public section

namespace RadiusBound

open SimpleGraph

-- Along the path with consecutive integer labels, one can walk directly to the right.
private lemma forward_dist {n a b : ℕ} (ha : a < n) (hab : a ≤ b) (hb : b < n) :
    (pathGraph n).dist ⟨a, ha⟩ ⟨b, hb⟩ ≤ b - a := by
  induction b, hab using Nat.le_induction with
  | base => simp
  | succ b hab ih =>
    have hb' : b < n := by omega
    have hc : (pathGraph n).Connected := connected_pathGraph.mpr (by omega)
    have step : (pathGraph n).dist ⟨b, hb'⟩ ⟨b + 1, hb⟩ = 1 :=
      dist_eq_one_iff_adj.mpr (pathGraph_adj.mpr (Or.inl rfl))
    have h := hc.dist_triangle (u := ⟨a, ha⟩) (v := ⟨b, hb'⟩) (w := ⟨b+1, hb⟩)
    rw [step] at h
    have := ih hb'
    omega

-- Each edge changes a label by one, so a walk cannot advance farther than its length.
private lemma walk_advance {n : ℕ} {u v : Fin n} (p : (pathGraph n).Walk u v) :
    v.val ≤ u.val + p.length := by
  induction p with
  | nil => simp
  | cons e p ih =>
    have h := pathGraph_adj.mp e
    simp only [Walk.length_cons]
    omega

/-- The middle vertex of P₉ is a center and the two endpoints realize the diameter. -/
theorem path_nine_invariants : (pathGraph 9).diam = 8 ∧ (pathGraph 9).radius.toNat = 4 := by
  have hc : (pathGraph 9).Connected := connected_pathGraph_add_one 8
  have hr : (pathGraph 9).radius ≤ 4 := by
    apply (radius_le_eccent (u := (4 : Fin 9))).trans
    apply ((pathGraph 9).eccent_le_iff _ _).mpr
    intro v
    rw [← (hc _ _).coe_dist_eq_edist]
    suffices h : (pathGraph 9).dist 4 v ≤ 4 by exact_mod_cast h
    rcases le_total 4 v.val with h | h
    · have h' := forward_dist (n := 9) (a := 4) (by decide) h v.isLt
      change (pathGraph 9).dist 4 v ≤ v.val - 4 at h'
      omega
    · rw [dist_comm]
      have h' := forward_dist v.isLt h (by decide : 4 < 9)
      change (pathGraph 9).dist v 4 ≤ 4 - v.val at h'
      omega
  have radUpper : (pathGraph 9).radius.toNat ≤ 4 := by
    simpa using ENat.toNat_le_toNat hr (by decide)
  have diamLower : 8 ≤ (pathGraph 9).diam := by
    obtain ⟨p, hp⟩ := hc.exists_walk_length_eq_dist 0 8
    have h := walk_advance p
    change 8 ≤ 0 + p.length at h
    rw [hp, zero_add] at h
    exact h.trans (dist_le_diam ((pathGraph 9).connected_iff_ediam_ne_top.mp hc))
  have h := diam_le_twice_radius (pathGraph 9) hc
  omega

/-- Any nonnegative base that works on the full class of graphs must be at least √8. -/
theorem base_lower_bound (b : ℝ) (hb : 0 ≤ b)
    (h : ∀ {n : ℕ}, 2 ≤ n → ∀ G : SimpleGraph (Fin n), G.Connected →
      (G.diam : ℝ) ≤ b ^ Real.sqrt (G.radius.toNat : ℝ)) : Real.sqrt 8 ≤ b := by
  have hpath := h (n := 9) (by decide) (pathGraph 9) (connected_pathGraph_add_one 8)
  rw [path_nine_invariants.1, path_nine_invariants.2] at hpath
  have hs : Real.sqrt (4 : ℝ) = 2 := by
    rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
  norm_num [hs, Real.rpow_two] at hpath
  exact Real.sqrt_le_iff.mpr ⟨hb, hpath⟩

end RadiusBound
