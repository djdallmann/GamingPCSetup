# Troubleshooting: Media Playback

This section covers different tools which can help in identifying the root cause of issues in relation to media playback whether it's realtime audio/video playback and game performance.

## Media eXperience Analyzer
If you experience audio or video glitches during regular use or during gameplay Media eXperience Analyzer is probably the best tool for the job as it offers
many unique visualizations and functions to help identify delays in the scheduler, process, thread and driver processing. 
If the evidence points you to graphics or driver processing delays then this and other tools may help identify the cause which could then help you communicate with the game developper to resolve the issues.

You may find this tool overwhelming at first since there's a lot going on so a beginner or intermediate level understanding of **Windows Internals** will help a lot, I'd recommend getting a copy of the book **Windows Internals 7th Edition Part 1** (for Windows 8/10) and reading the section on scheduling, processes, threads, and quantums.

### Download and Install
1. Download Windows Assessment and Deployment Kit (Windows ADK) for your version of windows - https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install
2. Install **Windows Performance Toolkit** and **Media eXperience Analyzer**
   * Windows Performance Toolkit includes xperf, Windows Performance Analyzer, Windows Performance Recorder, and GPUView.
   * Media eXperience Analyzer includes the processing and visualization software, and custom windows performance recorder profiles to capture the necessary data for the visuals.

### Real World Examples and Use Cases
For now I will point you to Defrag Tools for real world examples and use cases for Media eXperience Analyzer, I may add some personal analysis and use cases at a later date.
* https://channel9.msdn.com/Shows/Defrag-Tools/DefragTools-149-Media-eXperience-Analyzer-part-1
* https://channel9.msdn.com/Blogs/WinHEC/Video-Introduction-to-Media-eXperience-Analyzer-MXA-Part-2
* https://channel9.msdn.com/Blogs/WinHEC/Video-Introduction-to-Media-eXperience-Analyzer-MXA-Part-3-Glitch-Analysis
* https://channel9.msdn.com/Blogs/WinHEC/Video-Introduction-to-Media-eXperience-Analyzer-MXA-Part-4-Video-Glitch-Analysis
* https://channel9.msdn.com/Blogs/WinHEC/Video-Introduction-to-Media-eXperience-Analyzer-MXA-Part-5-Video-Glitch-Analysis-II
* https://channel9.msdn.com/Blogs/WinHEC/Video-Introduction-to-Media-eXperience-Analyzer-MXA-Part-6-Audio-Offload

## GPUView
### Download and Install
1. Download Windows Assessment and Deployment Kit (Windows ADK) for your version of windows - https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install
2. Install **Windows Performance Toolkit**
   * Windows Performance Toolkit includes xperf, Windows Performance Analyzer, Windows Performance Recorder, and GPUView.

### Real World Examples and Use Cases
Much like the above some of the best examples and use cases come from the source, see the following page made by the creator of GPUView for some real world examples using popular games.
* Matt's Webcorner - GPUView
  * https://graphics.stanford.edu/~mdfisher/GPUView.html
