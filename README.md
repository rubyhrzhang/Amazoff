# Operational Plan for the Amazoff Company

## Overview

Amazoff, a growing e-commerce company, is relocating to the UK and focuses on logistics. This project develops a one-year operational plan.

In this project, I have developed a suite of models to optimise warehousing, vehicle routing, and insurance policies using integer programming, 
simulations, and variance reduction techniques, offering cost-effective solutions with enhanced efficiency.  

## 1. Warehousing

- **Goal:** Optimize warehouse locations and client assignments.
- **Method:** Use AMPL to model costs, using ℓ1-distance for client-facility assignments.
- **Capacitated Model:** Incorporate facility capacities and client demands.

## 2. Vehicle Routing

- **Goal:** Optimize routing for composite clients.
- **Method:** Design routes using ℓ2-distance for travel costs.
- **Multiple Vehicles:** Explore cost reduction with three vehicles.

## 3. Depot Transportation

- **Objective:** Maximize profit under uncertainty in depot transport.
- **Approach:** Model vehicle loading with uncertain item data.

## 4. Insurance Simulation

- **Objective:** Assess risk of capital falling below a threshold.
- **Method:** Use discrete event simulation to model customer claims and behavior.
