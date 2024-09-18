<?php

include "Plan.php";
include "PlanManager.php";
include "Sprint.php";
include "Submission.php";
include "VacationPlan.php";

// Create the plan manager
$manager = new PlanManager();

// Add a vacation plan
$plan1 = new VacationPlan("Museum visit", "Barcelona", "2024-09-20", "Cultural");
$manager->addPlan($plan1);

// Add an ItAcademy submission
$sprint1 = new Sprint("Laravel API");
$submission1 = new Submission("Final Submission", $sprint1, "2024-09-21", "https://github.com/user/repo", "Submit before 6 PM");
$manager->addPlan($submission1);

// Add another vacation plan on a different date
$plan2 = new VacationPlan("Lunch at restaurant", "Girona", "2024-09-22", "Restaurant");
$manager->addPlan($plan2);

// Show existing plans
$manager->showPlans();

// Perform and cancel activities
$plan1->perform();
$plan1->cancel();

// Submit and resubmit an ItAcademy submission
$submission1->perform();
$submission1->resubmit();
?>