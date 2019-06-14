# Troubleshooting: Electrical Interference
Many people report unusual or unexpected behavior on what appears to be well built stable computers sytems, the cause of this is most likely a high level of electrical noise or interference.

# Disclaimer 
I'm not an electrical engineer or subject matter expert, most of what is shared below is based on *translations* of reputable public works and research, see my Electrical section in Technical Reference. 
Use this guide at your own risk, electricity can be very dangerous please do your due dilegence and research before trying anything you're uncomfortable or unfamiliar with. 
You are fully responsible for any loss, harm or damages caused by using the information described on this page.

## Why does this happen?
Computers like many other electronics are particularly sensitive, manufacturers we assume do their best to design products to reduce interference by using isolators/transformers/chokes, or how the traces run on a motherboard, however there is always expected to be some level of noise flowing through the system purely how electronic systems work, we must then do our best to isolate and reduce those issues to where it isn't audible or perceivable.

## How can ground loops be created in a PC build configuration?
Lots of ways actually but in brief anytime you have more than one grounded system (PC, Monitor, Router) joined together (by a cable in some cases) that also carries ground, so yea pretty much every PC configuration... It can introduce what is called a ground loop which overall increases the noise level flowing through the system. Ground loops in general are more well known in the audio production industry specifically related to the amount of noise that is being produced in recordings as a result of multiple interconnected grounded systems (electrical instruments, pedals, amps, synthesizers) but after a few google searches you'll quickly see how they are directly related.

## How can we reduce the noise floor in our computer systems?
The better question is what produces noise and how is it transferable, a brief example of things that produce different types of interference are transformers (AC/DC converters those blocks on your laptop power cables), AC current, radio waves, fans. 

* **Fans** (case intake fans, computer fans, gpu fans) as an example their near field magnetic interference increases as fan speed increases.
* **AC Current**, a.k.a the cords that run power to your monitor, router, and pc all produce near field magnetic interference/fields.
* **Power blocks (AC/DC converters) on laptop charger cables**, these produce very significant near field interference.
* **Radio waves**, your wireless devices, signal strength and their operating frequency

### Sooo... how do I reduce these types of interference... 
The answer in most cases is **distance**, orientation and proximity, as interference isn't always 100% constant, static, or radiating all in the same way as you might assume. 
Depending on the type of interference, strength, shielding and carrier (cable) the signal might radiate differently and will represent different forms of radiation which may be omnidirectional, unidirectional, or other general *physical non visible* representation.
there are other ways to reduce interference which may already be in front of you. Look at your USB (keyboard, mouse) and monitor cables they should already have black cylinders around the cables on one or both ends which is also know as a ferrite choke.

A **ferrite choke** is most often place near the receiver to reduce noise before entering the receiving system, in some cases it is placed on both ends for cables for systems that use **bi-directional data** then both receiving ends have chokes on them. 
Also note the physical size of the ferrite choke determines the frequency range that it is likely to protect against, **High range or lower range frequencies**, so to say **bigger isn't always better** and it depends on what you're protecting against.

Reduce interfering near field (EMI) and far field (RFI) interference in some cases can be easy but also in some cases out of our control (bad design in motherboard or component).

## General Tips and Recommendations
1. Always make sure your system is stable before trying to resolve any issues related to electrical interference:**
   * Ensure you have adequate cooling and you're system isn't thermal throttling, cpu, gpu, memory 
   * Try to reduce dynamic frequency changes whether it's fan speeds, cpu, memory speeds
   * Set fan speeds to a constant value while providing adequate cooling under load
   * Ensure you have stable/consistent fps
   * Turn off power saving features during testing as these will throttle or change frequencies automatically depending on idle use.
2. Disconnect any unecessary interconnected grounded systems
   * Do you have a speaker system, or other interconnected component that may be uncessary during testing?
   * Keep it simple..
3. Make sure you have clean and stable power supply input
   * Use quality power supply units that provide higher output than your overall draw (power consumption) for the components in your system.
   * If you're in north america you'll likely see the overall voltages in the range of 120, this can fluctuate (+/- 5) and may never be 120 constant and is expected.
   * Reduce the amount of electrical systems connected to your computer systems electrical circuit (circuit breaker line)
     * **Turn off your computer or any other sensitive electronics you believe to be on the circuit first, this could be in the same or adjoining room, and even in the hallway**
     * You can test this by turning off the breaker switch for which your computer is connected then determine what else has turned off and may be connected to the same circuit.
     * Use a device like a lamp to see which plugs are connected while the breaker is off.
     * Use a multimeter to measure the voltage going through the **outlets(1), plugs(2) and cords(3)**, to ensure they match the rated voltage of your circuit breaker.
     * If you have unstable or unclean power consider getting an 'Online UPS or Double Conversion UPS with Pure Sine Wave', or Power Conditioner (Furman etc). 
       * These mentioned are not interchangable or equal, results may vary as each may provide similar but different functionality.
4. Try to fix ground loop issues first by changing the path and flow of electricity for common grounds in the interconnected systems.
   * Ensure you have ground in the first place for interconnected grounded components and systems
   * Ensure your outlets are wired properly (neutral, hot, ground) - By a low cost GFCI Plug Tester from your local hardware store $20
   * Ensure power cord plugs, and all used power bar/conditioner **plugs** are passing electricity properly to ground, netural, hot (borrow/buy and learn to use a multimeter safely)
   * Place all grounded interconnected systems (router, pc, monitor) and devices on the same powerbar, this may help ground find the same common path instead of making the ground loop worst.
   * Try putting the ground of one of the interconnected systems (monitor, router) on another electrical circuit by using an extension cord (must have ground)
     * Note: If you followed the steps above you've already determined determine what plugs/outlets are shared on the same electrical breaker circuits.
5. Increase the distances between your cables (AC Power Cables, USB, DVI-D, Diplay Port), if cables must touch they should cross (+) each other at 90 degree angles
   

** Want to learn a LOT more, take a look at the Electrical References section on my github **
https://github.com/djdallmann/GamingPCSetup/tree/master/Technical%20References

## Credits
This current written work is based on *translations* of reputable public works and research, see my Electrical section in Technical Reference. 
It is also written and inspired by the dedication, work, tests and observations of a group of people with common issues and goals, most notably:

**Ashr** - https://steamcommunity.com/profiles/76561197979240181/

**Nug** - https://steamcommunity.com/profiles/76561198042287644/

**Timecard aka TC!** - http://steamcommunity.com/id/tcard

**Some history**
https://docs.google.com/document/d/1Ihak2mMEogNm3IkoJxizY1YN7vXjuNr_NfEdAnjTAII/
