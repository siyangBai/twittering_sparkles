# twittering sparkles

## Introduction


The project seeks to create a **win-win mode** between hotels near bird sanctuaries and research institutions that use machine learning to identify the collection of bird sounds for bird observation. Animated projections that visualize bird information are placed on the walls of the hotel lobby by sharing the bird sounds observed in the bird sanctuary near the hotel. Attracting more bird lovers to the hotel while acquiring funds for bird researchers.

Given that there are already various machine learning related discussions and open source tool available ( <https://www.kdnuggets.com/2014/12/open-source-tools-machine-learning.html> ), also bird species recognition with sounds. My code here **only deal with artistical part** of the whole data pipeline. The species of birds are hard coded in my program, but the visual effects such as numbers of moving shapes are still generatively based on input like volume.

This code needs to **input the audio** of a bird's voice and **pre-distinguish the different bird species** (the bird's voice is collected in the protected area and distinguish different types by machine recognition), and then generated in a specific area of the background (corresponding to the actual position) Particles representing birds, different colors represent different bird species, and round particles represent rare birds.
### demo
![gif](image/Demo.gif)
### How to Run This Code
  * Download and install Processing on <https://processing.org/download/>
  
  * Save the "birdssing" file to the "data" folder of the processing folder 
  
  * Run the pde file "flocking.pde"




## Technical Inspiration

* **PAPER**  Machine Learning About Identifying Bird Call 

<https://arxiv.org/pdf/1810.09078.pdf>


* **NEWS**  New Monitoring Bird Methods

<https://www.brehm-fonds.de/en/projects/monitoring-of-resident-and-migratory-birds-in-the-brazilian-pantanal/> 





## Reference
* https://processing.org/examples/flocking.html Flocking by **Daniel Shiffman**
* https://processing.org/reference/libraries/sound/index.html
