# vitalli-xyz alu tap

We expect the std. deviation to be *0.001* when tuned.

## commissioning

### before belt tensioning as a reference

```console
python3 /home/pi/probe_accuracy_tests/probe_accuracy_test_suite.py --corner --export_csv
Probe type: ...
Probe type: Tap mode detected
Safe z has not been set in klicky-variables or in [safe_z_home]
Enter safe z height to avoid crash:20

Corner test:
Test probe around the bed to see if there are issues with individual drives
Leveling... Done
Test number: 4...3...2...1...Done

                                      min       max     first      last      mean       std  count     range     drift
test
1: corner 30 samples (25, 275)   0.900391  0.930703  0.930703  0.900391  0.903610  0.005592     30  0.030312 -0.030312
2: corner 30 samples (275, 275)  0.901328  0.925391  0.925391  0.901953  0.903516  0.004400     30  0.024063 -0.023438
3: corner 30 samples (25, 25)    0.902891  0.921328  0.921328  0.902891  0.905016  0.003419     30  0.018437 -0.018437
4: corner 30 samples (275, 25)   0.901328  0.918203  0.918203  0.901328  0.903484  0.003097     30  0.016875 -0.016875
```

#### repeatability test - it is long

```console
python3 /home/pi/probe_accuracy_tests/probe_accuracy_test_suite.py -r
Probe type: ...
Probe type: Tap mode detected
Homing
Safe z has not been set in klicky-variables or in [safe_z_home]
Enter safe z height to avoid crash:20

Repeatability test:
Take 20 probe_accuracy tests to check for repeatability
Test number: 20...19...18...17...16...15...14...13...12...11...10...9...8...7...6...5...4...3...2...1...Done

                            min       max     first      last      mean       std  count     range     drift
test
01: center 10 samples  0.914688  0.945625  0.939063  0.917188  0.921624  0.007159    200  0.030937 -0.021875
02: center 10 samples  0.915938  0.946563  0.941563  0.918125  0.922325  0.007123    200  0.030625 -0.023438
03: center 10 samples  0.915313  0.945625  0.943125  0.919375  0.922530  0.007201    200  0.030312 -0.023750
04: center 10 samples  0.916250  0.946250  0.941563  0.921250  0.922044  0.007038    200  0.030000 -0.020313

Your probe config uses median of 10 sample(s) over 4 tests
Below is the statistics on your median Z values, using different probe samples

       mean       min       max       std     range  sample_count
0  0.941993  0.941250  0.942969  0.000726  0.001718             1
1  0.933672  0.933594  0.933906  0.000156  0.000312             2
2  0.924453  0.924063  0.925000  0.000469  0.000937             3
3  0.923047  0.922656  0.923438  0.000325  0.000781             4
4  0.922110  0.921875  0.922500  0.000299  0.000625             5
5  0.921407  0.920938  0.921875  0.000403  0.000937             6
6  0.920782  0.920157  0.921250  0.000460  0.001093             7
7  0.920391  0.919688  0.920938  0.000534  0.001250             8
8  0.920157  0.919688  0.920625  0.000403  0.000937             9
9  0.919844  0.919375  0.920313  0.000404  0.000938            10
```

### final belt tensioning results

```console
python3 probe_accuracy_test_suite.py --speedtest
Probe type: ...
Probe type: Tap mode detected
Safe z has not been set in klicky-variables or in [safe_z_home]
Enter safe z height to avoid crash:20

Z-Probe speed test:
Test a range of z-probe speed

Minimum speed?  4
Maximum speed?  10
Steps between speeds?  1

Leveling... Done
Test speeds: 4.0 mm/s...5.0 mm/s...6.0 mm/s...7.0 mm/s...8.0 mm/s...9.0 mm/s...10.0 mm/s...Done

           min       max     first      last      mean       std  count     range     drift
test
4.0   1.395981  1.424731  1.424731  1.395981  1.401512  0.008846     10  0.028750 -0.028750
5.0   1.400981  1.428794  1.428794  1.400981  1.405637  0.008558     10  0.027813 -0.027813
6.0   1.402544  1.430981  1.430981  1.402856  1.407388  0.008634     10  0.028437 -0.028125
7.0   1.406294  1.434731  1.434731  1.406294  1.410856  0.008596     10  0.028437 -0.028437
8.0   1.408481  1.439106  1.439106  1.408481  1.413388  0.009226     10  0.030625 -0.030625
9.0   1.414419  1.440981  1.440981  1.414419  1.418450  0.008123     10  0.026562 -0.026562
10.0  1.413481  1.438794  1.438794  1.413481  1.418075  0.007699     10  0.025313 -0.025313
```

```console
python3 /home/pi/probe_accuracy_tests/probe_accuracy_test_suite.py --corner --export_csv
Probe type: ...
Probe type: Tap mode detected
Safe z has not been set in klicky-variables or in [safe_z_home]
Enter safe z height to avoid crash:20


```
