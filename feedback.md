

## BeFake

##### https://github.com/lmu-cmsi2022-spring2023/your-own-BeFake

| Category | Feedback | Points |
| --- | --- | ---: |
| | _ideation.md_ | |
| • In-class workshop | Clement, Elijah, and Dawit participated in-class—points will be assigned individually (–4) | -4 |
| • Audiences | Audiences are listed | 5/5 |
| • Ten (10) needs | Ten needs are stated sufficiently | 10/10 |
| • Three (3) projects | Three possible projects are listed | 6/6 |
| • Three (3) sets of goals/ideas | Each project has goals/ideas attached to it | 6/6 |
| • Project choice | A winning project/app is indicated | 3/3 |
| • Content-completion | _ideation.md_ first committed on 0424 but with no content; all other information not committed until 0429 (–5) ***The group was under the impression that we had until 0505 to submit our work due to the extension granted by skiness*** | -5 |
| | _pitch.md_ | |
| • In-class workshop | Elijah and Alex workshopped the pitch in-class—points will be assigned individually (–4) | -4 |
| • Inspiration statement | Inspiration statement is provided—not quite phrased according to what is specified in Dr. Toal’s [ideation process page](https://cs.lmu.edu/~ray/notes/ideation/) but is sufficiently audience-centric to work | 4/4 |
| • 2–3 possible solutions | Possible solutions are given | 10/10 |
| • Chosen fleshed-out idea | Chosen preliminary idea is fleshed out | 12/12 |
| • Human story | Human story is provided, phrased closely enough to what’s in Dr. Toal’s [ideation process page](https://cs.lmu.edu/~ray/notes/ideation/) | 4/4 |
| • Content-completion | _ideation.md_ first committed on 0424 but with no content; all other information not committed until 0505 (–7) ***The group was under the impression that we had until 0505 to submit our work due to the extension granted by skiness*** | -7 |
| | _about.md_ | |
| • Project title | Title is provided | 2/2 |
| • Team names and roles | Team members and your roles are listed | 12/12 |
| • Audience and their needs | Audience and their needs are explained | 10/10 |
| • Screenshots/video/demo | Screenshots are provided | 14/14 |
| • Technology highlights | Technology details are provided | 12/12 |
| • Credits | Credits are provided—but on a separate note, the aforementioned content was not given in a Markdown file as stipulated by the instructions (–5) | -5 |
| • In-class prsentation | Final presentation successfully delivered in class 👏🏼👏🏼👏🏼 |  |
| | **Baseline functionality** | |
| • Third-party web service API | The random image generator doesn't really add anything to your app (–1), and the API results don't actually show up in the app since the profile tab just loads infinitely (–8) | 16/25 |
| • Authentication | Authentication is done via custom Firestore implementation | 10/10 |
| • Database | Database use is derived from blog code, with storing posts and the number of likes per post. So although database use is indeed present, it would be unfair to give this work the same credit as other groups, which expanded database use more substantially from the prior assignment (–5) | 20/25 |
| | **Implementation specifications** | |
| • Model objects | Model objects are generally OK, but the `CodingKeys` is superfluous for both objects (–1) | 7/8 |
| • Interaction with back-end | The back-end doesn't sync with the front-end: liking a post requires the user to force-refresh the page by closing and reopening the app before the "like" button is updated, and adding a post seems to load indefinitely (–10) | 2/12 |
| • Abstraction of back-end | Back-end functionality is all directly implemented in your views (–12) | 0/12 |
| • Feedback | In-progress feedback presented with `ProgressView` | 7/7 |
| • Error-handling | If the user tries to sign up with an email that's already in use, there doesn't seem to be a way back to the original login screen (the `SignIn` button doesn't seem to work) (–1). Additionally, you have places where you either have an empty `catch {}` which is not a good practice to have, or you only have error handling for devs, not for users (–2) | 4/7 |
| • Layout and composition | Layout is appropriate for this type of app | 7/7 |
| • Colors and other visuals | Colors and visuals are fairly standard dark mode | 7/7 |
| • Input views and controls | Input views and controls are generally well-chosen | 7/7 |
| • Animations/transitions | Animation on deletion of image from the `CreateNewPost` view | 5/5 |
| • Programmed graphics | Programmed graphics in the custom login screen | 5/5 |
| • Custom app icon | App icon looks good | 3/3 |
| | **Other categories** | |
| Code maintainability | There were issues with the _.xcodeproj_ file's references, which causes your project to fail to build. (–5) deduction because your project failed to build the way it was submitted.<br><br>As submitted, there is somewhat mixed-up content in the repository…there are _two_ Xcode project files here, with the right one being in the _BFProj_ folder. A little file cleanup would have gone a long way toward avoiding potential confusion to developers who are new to the repository (–1) | -6 |
| Code readability | No notable code readability issues seen |  |
| Version control | Commit count is on the low side given the scope of the assignment, and a lot of the commits are still via upload—the team needs to learn how to use _git_ directly, the way it’s done in industry (–5)<br><br>It should also be noted that Elijah has contributed over 5,000 lines of code to the repository—Alex is a galactically distant second with 73 lines committed and Clement has 2 lines committed. Dawit has none. This is starkly inequitable and belies any credible notion of teamwork (–50) | -55 |
| Punctuality | First commit 4/24 3:30pm; last commit 5/6 10:23am. Accommodated to 5/5 11:59:59.999pm due to finals week illness, so still a little late (–2) | -2 |
| | **Total** | **122/250** |
