# Verilog-202
This is a program intended to run a series of 16 LEDs (called Lamps) blinking on an <strong>Intel De2i-150 FPGA board</strong>.
## Functionalities
The LEDs are supposed to run in the following manner:
<ul>
  <li>The lamps are turned ON gradually from lamp[0] to lamp[5].</li>
  <li>The lamps are turned OFF gradually from lamp[5] (max) to lamp[0] (min).</li>
  <li>The lamps are turned ON gradually from lamp[0] to lamp[10].</li>
  <li>The lamps are turned OFF gradually from lamp[10] (max) to lamp[5] (min).</li>
  <li>The lamps are turned ON gradually from lamp[5] to lamp[15].</li>
  <li>Finally, the lamps are turned OFF gradually from lamp[15] to lamp[0], return to initial state.</li>
</ul>
<strong>Notes</strong>: At each kickback point (lamp[5] and lamp[10]), if flick signal is ACTIVE, the lamps will turn OFF gradually again to the min lamp of the previous state, then continue operation as above description. For simplicity, kickback point is considered only when the lamps are turned ON gradually, except the first state.
