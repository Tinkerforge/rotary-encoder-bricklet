/* rotary-encoder-bricklet
 * Copyright (C) 2013 Olaf Lüke <olaf@tinkerforge.com>
 *
 * rotary-encoder.h: Implementation of Rotary Encoder Bricklet messages
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#ifndef ROTARY_ENCODER_H
#define ROTARY_ENCODER_H

#include <stdint.h>
#include "bricklib/com/com_common.h"

#define FID_GET_COUNT 1
#define FID_SET_COUNT_CALLBACK_PERIOD 2
#define FID_GET_COUNT_CALLBACK_PERIOD 3
#define FID_SET_COUNT_CALLBACK_THRESHOLD 4
#define FID_GET_COUNT_CALLBACK_THRESHOLD 5
#define FID_SET_DEBOUNCE_PERIOD 6
#define FID_GET_DEBOUNCE_PERIOD 7
#define FID_COUNT 8
#define FID_COUNT_REACHED 9
#define FID_IS_PRESSED 10
#define FID_PRESSED 11
#define FID_RELEASED 12

typedef struct {
	MessageHeader header;
	bool value;
} __attribute__((__packed__)) BoolMessage;

typedef struct {
	MessageHeader header;
} __attribute__((__packed__)) StandardMessage;

void is_pressed(const ComType com, const StandardMessage *sm);

void invocation(const ComType com, const uint8_t *data);
void constructor(void);
void destructor(void);
void tick(const uint8_t tick_type);

#endif
