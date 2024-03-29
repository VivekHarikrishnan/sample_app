Feature: Signing in
	Scenario: Unsuccessful sign in
		Given a user visits the sign in page
		When he submits invalid sign in information
		Then he should see an error message
	Scenario: Successful sign in
		Given a user visits the sign in page
		And user has an account
		And the user submits valid sign in information
		Then he should see his profile page
		And he should see sign out link