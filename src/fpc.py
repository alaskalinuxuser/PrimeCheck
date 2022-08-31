'''
 Copyright (C) 2021-2022 Piotr Lange

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 PrimeCheck is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''

def isPrime(numberToCheck):
	numberToCheck = int(numberToCheck)

	if numberToCheck <= 1:
		return [False, 0]
	if numberToCheck == 2:
		return [True, 0]
	if numberToCheck == 3:
		return [True, 0]
	if numberToCheck % 2 == 0:
		return [False, 2]
	if numberToCheck % 3 == 0:
		return [False, 3]
	
	lim = int(numberToCheck**(1/2)) + 1

	for iii in range(4, lim, 6):
		if numberToCheck % iii == 0:
			return [False, iii]
		if numberToCheck % (iii + 2) == 0:
			return [False, iii + 2]

	return [True, 0]
