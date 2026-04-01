import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_fibonacci(dut):
    dut._log.info("Iniciando simulación de Fibonacci")

    # Configurar reloj (10us = 100KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # --- RESET ---
    dut._log.info("Aplicando Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 5)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1) # Esperar un ciclo tras reset

    # --- VERIFICACIÓN DE SECUENCIA ---
    # Según tu Verilog:
    # Ciclo 1: a=0, b=1 -> uo_out=0
    # Ciclo 2: a=1, b=1 -> uo_out=1
    # Ciclo 3: a=1, b=2 -> uo_out=1
    # Ciclo 4: a=2, b=3 -> uo_out=2
    # Ciclo 5: a=3, b=5 -> uo_out=3
    
    expected_sequence = [0, 1, 1, 2, 3, 5, 8, 13]
    
    for val in expected_sequence:
        current_out = int(dut.uo_out.value)
        dut._log.info(f"Salida actual: {current_out}, Esperado: {val}")
        assert current_out == val
        await ClockCycles(dut.clk, 1)

    dut._log.info("¡Test de Fibonacci completado con éxito!")

