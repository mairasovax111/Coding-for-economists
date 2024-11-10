*Firstly, I wanted to fix data quality related errors and convert strings into numerics. I did not convert all of them because my goal was to show that I can do it. Therefore, there will be some observations in red. 
destring host_response_rate host_listings_count host_total_listings_count bathrooms bedrooms beds review_scores_rating review_scores_accuracy review_scores_cleanliness review_scores_checkin review_scores_communication review_scores_location review_scores_value reviews_per_month, replace force

*Creating a new numeric variable from already existing string variable when 1 is "t" and 0 is "f"
gen requires_license_numeric = ( requires_license == "t")
gen host_identity_verified_numeric = ( host_identity_verified == "t")
gen host_has_profile_pic_numeric = ( host_has_profile_pic == "t")
gen is_location_exact_numeric = ( is_location_exact == "t")
gen require_guest_phone_vernumeric = ( require_guest_phone_verification == "t")
gen host_is_superhost_numeric = (host_is_superhost == "t")


*Here, I fixed data quality errors by dropping missing values in one selected variable 
drop if missing(review_scores_value)

*In this part, I created summary statistics
sum host_response_rate guests_included  latitude bathrooms availability_30 availability_365  review_scores_accuracy review_scores_communication calculated_host_listings_count host_listings_count longitude     bedrooms   minimum_nights  availability_60 number_of_reviews review_scores_cleanliness review_scores_location reviews_per_month   accommodates  beds     host_total_listings_count    maximum_nights  availability_90  review_scores_rating review_scores_checkin review_scores_value

*Function to install a summary statistics table package first
ssc install estout

*Creating summary statistics table
estpost summarize host_response_rate guests_included  latitude bathrooms availability_30 availability_365  review_scores_accuracy review_scores_communication calculated_host_listings_count host_listings_count longitude     bedrooms   minimum_nights  availability_60 number_of_reviews review_scores_cleanliness review_scores_location reviews_per_month   accommodates  beds     host_total_listings_count    maximum_nights  availability_90  review_scores_rating review_scores_checkin review_scores_value

*Downloading the table and then transferring it to my folder
esttab using "output/summary_statistics1.txt", cells("count mean sd min max") replace

*Bar graph creation and export to my computer 
graph bar (mean) bathrooms (mean) bedrooms (mean) beds (mean) guests_included

graph export "C:\Users\Albakassova_Maira\Desktop\Assignment\output\graphs\Graph1.png", as(png) name("Graph")

*Histogram
hist availability_365
hist availability_365, title ("Availability")

*Exporting the graph from the software to my folder on computer
graph export "output/graphs/Graph.png", replace


*Created a copy of the original var 'beds',  then filtered its observations by its quantity
gen beds_copy = beds
keep if beds_copy >= 5
*Filtered the variables
keep host_response_rate guests_included  latitude bathrooms availability_30 availability_365  review_scores_accuracy review_scores_communication calculated_host_listings_count host_listings_count longitude     bedrooms   minimum_nights  availability_60 number_of_reviews review_scores_cleanliness review_scores_location reviews_per_month   accommodates  beds     host_total_listings_count    maximum_nights  availability_90  review_scores_rating review_scores_checkin review_scores_value beds_copy

*I created a categorical transformation of the variables by grouping them into categories: 1 for a "low number of beds," 2 for a "medium number of beds," and 3 for a "high number of beds." This is one type of categorical transformation.
generate beds_category = .
replace beds_category = 1 if beds >=5 & beds < 8
replace beds_category = 2 if beds >=8 & beds < 12
replace beds_category = 3 if beds >= 12