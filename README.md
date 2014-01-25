## README for PEEPS PROJECT (aka: SEE-MORE)

### Goals
- Learn how to work with OAuth
- Gain experience in consuming with 3rd party APIs
- Build your own API
- Coordinate with a larger team
- Work within the structure of 2 one-week Sprints
- Learn how to work with Pivotal Tracker
- Accumulate experience points in Rails

### Guidelines

- Groups of four (one w/three) will work with a Teacher acting as a Project Manager
- Each group will be responsible to deliver a final product to the Product Owner (Elise)
- Use pivotaltracker.com as a project management service
- Practice TDD (rspec) to lead the development process of Models and Controllers
- Build a logical user-flow that moves across multiple controllers and models
- Use HTML/CSS to style your website.

### Expectations

- Build a feed aggregator service that allows users to login via Twitter, Github, or Facebook. It will allow users to view updates from all their tracked feeds in one location, and share them back to associated social media services.

### Technical Requirements

*Bronze* _\(20 points\)_


- Allows Users to sign in and out using OmniAuth's Developer Strategy
- Can aggregate feeds from
- One or more Twitter users
- One or more Tumblr users
- Any other ATOM/XML/RSS feed from blogs or news service  

*Silver* _\(20 points\)_

All of Bronze, plus:

- Allows Users to sign-up and login with a Facebook, Twitter, or Github account
- Can aggregate feeds from
- The User's Facebook feed (if associated with a Facebook account)
- One or more Github users
- One or more Instagram users
- Allows Users to share favorite stories back to social media services

*Gold* _\(20 points\)_

All of Silver, plus:

- Can aggregate feeds from
- One or more FourSquare users
- One or more SoundCloud users
- One or more Flickr users
- Uses cron to periodically update feeds without duplication
- Can send email or SMS messages to users to update them


*Platinum* _\(10 points\)_

- offers API  of aggregated feeds
- add a Google Map that shows the location of any feed items that contain geolocative information
- Evaluation

### Learning Goals _\(10 points\)_

- Demonstrate comprehension of Rails
- Comfort with Pivotal Tracker (and any other project tools used)
- Working as a team
- Accepting challenges by working on parts of the project outside your individual comfort zone
- Client Satisfaction (10 points)
- Visually appealing and polished
- No major bugs
- Minor bugs noted in Pivotal Tracker or as a Github issue
- Good communication with Project Owner
- Code Quality (10 points)

### Metrics
- Flog: no Controller method > 25, no Model method > 15
- Rubocop: no more than 15 code style issues
- Brakeman: no major security issues
- Code Coverage: 90\%+
 
*User Stories*

Each team will meet with the Product Owner at the outset to develop a set of user stories and precise requirements in Pivotal Tracker.
