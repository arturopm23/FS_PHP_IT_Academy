<?php

class PlanManager {
    private $plans = [];

    public function addPlan($plan) {
        if ($this->isDateAvailable($plan->date)) {
            $this->plans[] = $plan;
            echo "Plan successfully added: " . $plan->name . " for " . $plan->date . "<br>";
        } else {
            echo "Error: A plan or submission already exists on this date: " . $plan->date . "<br>";
        }
    }

    private function isDateAvailable($date) {
        foreach ($this->plans as $plan) {
            if ($plan->date === $date) {
                return false;
            }
        }
        return true;
    }

    public function showPlans() {
        foreach ($this->plans as $plan) {
            echo "Plan: " . $plan->name . " on " . $plan->date . "<br>";
        }
    }
}
