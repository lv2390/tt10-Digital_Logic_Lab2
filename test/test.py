# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_bitwise_and(dut):
    dut._log.info("Start Bitwise AND Test")

    # Setup Clock (not required for combinational logic, but needed by TinyTapeout)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset logic
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)  # Reset for 2 cycles
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)  # Wait one cycle after reset

    dut._log.info("Testing Bitwise AND Function")

    test_cases = [
        (0b11001100, 0b10101010, 0b10001000),  # Example: 11001100 & 10101010 = 10001000
        (0b11111111, 0b00000000, 0b00000000),  # 11111111 & 00000000 = 00000000
        (0b00001111, 0b11110000, 0b00000000),  # 00001111 & 11110000 = 00000000
        (0b11111111, 0b11111111, 0b11111111),  # 11111111 & 11111111 = 11111111
    ]

    for a, b, expected_output in test_cases:
        dut.ui_in.value = a  # A input
        dut.uio_in.value = b  # B input

        await ClockCycles(dut.clk, 1)  # Allow time for logic to settle

        # Log the test case
        dut._log.info(f"Test case A={bin(a)}, B={bin(b)} -> Expected Output={bin(expected_output)}, DUT Output={bin(dut.uo_out.value)}")

        # Assertion to check expected behavior
        assert int(dut.uo_out.value) == expected_output, (
            f"Test failed for A={bin(a)}, B={bin(b)}. Expected {bin(expected_output)}, "
            f"but got {bin(dut.uo_out.value)}")

    dut._log.info("All Bitwise AND tests passed!")

