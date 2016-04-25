/* rotary-encoder-bricklet
 * Copyright (C) 2013 Olaf Lüke <olaf@tinkerforge.com>
 *
 * rotary-encoder.c: Implementation of Rotary Encoder Bricklet messages
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

#include "rotary-encoder.h"

#include "bricklib/bricklet/bricklet_communication.h"
#include "bricklib/utility/util_definitions.h"
#include "bricklib/utility/init.h"
#include "bricklib/drivers/adc/adc.h"
#include "brickletlib/bricklet_entry.h"
#include "brickletlib/bricklet_simple.h"
#include "config.h"

#define SIMPLE_UNIT_COUNT 0

const SimpleMessageProperty smp[] = {
	{SIMPLE_UNIT_COUNT, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // FID_GET_COUNT
	{SIMPLE_UNIT_COUNT, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // FID_SET_COUNT_CALLBACK_PERIOD
	{SIMPLE_UNIT_COUNT, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // FID_GET_COUNT_CALLBACK_PERIOD
	{SIMPLE_UNIT_COUNT, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // FID_SET_COUNT_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_COUNT, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // FID_GET_COUNT_CALLBACK_THRESHOLD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_SET}, // FID_SET_DEBOUNCE_PERIOD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_GET}, // FID_GET_DEBOUNCE_PERIOD
};

const SimpleUnitProperty sup[] = {
	{NULL, SIMPLE_SIGNEDNESS_INT, FID_COUNT, FID_COUNT_REACHED, SIMPLE_UNIT_COUNT}, // count
};

const uint8_t smp_length = sizeof(smp);

const int8_t encoder_table[4][4] = {
    { 0,  1, -1,  0},
    {-1,  0,  0,  1},
    { 1,  0,  0, -1},
    { 0, -1,  1,  0}
};

void is_pressed(const ComType com, const StandardMessage *sm) {
	BoolMessage bm;
	bm.header        = sm->header;
	bm.header.length = sizeof(BoolMessage);
	bm.value         = !(PIN_ENCODER_BUTTON.pio->PIO_PDSR & PIN_ENCODER_BUTTON.mask);

	BA->send_blocking_with_timeout(&bm,
	                               sizeof(BoolMessage),
	                               com);
}

void invocation(const ComType com, const uint8_t *data) {
	const uint8_t fid = ((MessageHeader*)data)->fid;

	switch(fid) {
		case FID_GET_COUNT:
		case FID_SET_COUNT_CALLBACK_PERIOD:
		case FID_GET_COUNT_CALLBACK_PERIOD:
		case FID_SET_COUNT_CALLBACK_THRESHOLD:
		case FID_GET_COUNT_CALLBACK_THRESHOLD:
		case FID_SET_DEBOUNCE_PERIOD:
		case FID_GET_DEBOUNCE_PERIOD: {
			simple_invocation(com, data);

			if(fid == FID_GET_COUNT) {
				if(((BoolMessage*)data)->value) {
					BC->encoder_value_count = 0;
					BC->value[0] = 0;
				}
			}
			break;
		}

		case FID_IS_PRESSED: {
			is_pressed(com, (StandardMessage*)data);
			break;
		}

		default: {
			BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
			break;
		}
	}
}

void constructor(void) {
	_Static_assert(sizeof(BrickContext) <= BRICKLET_CONTEXT_MAX_SIZE, "BrickContext too big");

	simple_constructor();

    PIN_ENCODER_A.type = PIO_INPUT;
    PIN_ENCODER_A.attribute = PIO_PULLUP;
    BA->PIO_Configure(&PIN_ENCODER_A, 1);

    PIN_ENCODER_B.type = PIO_INPUT;
    PIN_ENCODER_B.attribute = PIO_PULLUP;
    BA->PIO_Configure(&PIN_ENCODER_B, 1);

    PIN_ENCODER_BUTTON.type = PIO_INPUT;
    PIN_ENCODER_BUTTON.attribute = PIO_PULLUP;
    BA->PIO_Configure(&PIN_ENCODER_BUTTON, 1);

    BC->encoder_value_last = PIN_ENCODER_A.pio->PIO_PDSR & PIN_ENCODER_A.mask ? 1 : 0;
    BC->encoder_value_last |= PIN_ENCODER_B.pio->PIO_PDSR & PIN_ENCODER_B.mask ? 2 : 0;
    BC->pressed = !(PIN_ENCODER_BUTTON.pio->PIO_PDSR & PIN_ENCODER_BUTTON.mask);
}

void destructor(void) {
	simple_destructor();
}

void tick(const uint8_t tick_type) {
	if(tick_type & TICK_TASK_TYPE_CALCULATION) {
		uint8_t encoder_value = PIN_ENCODER_A.pio->PIO_PDSR & PIN_ENCODER_A.mask ? 1 : 0;
		encoder_value |= PIN_ENCODER_B.pio->PIO_PDSR & PIN_ENCODER_B.mask ? 2 : 0;

		int8_t add = encoder_table[BC->encoder_value_last][encoder_value];
		BC->encoder_value_count += add;
		BC->encoder_value_last = encoder_value;

		BC->value[0] = BC->encoder_value_count/4;
	}

	if(tick_type & TICK_TASK_TYPE_MESSAGE) {
		if(!(PIN_ENCODER_BUTTON.pio->PIO_PDSR & PIN_ENCODER_BUTTON.mask)) {
			if(!BC->pressed) {
				BC->pressed = true;
				StandardMessage sm;
				BA->com_make_default_header(&sm, BS->uid, sizeof(StandardMessage), FID_PRESSED);
				BA->send_blocking_with_timeout(&sm,
											   sizeof(StandardMessage),
											   *BA->com_current);
			}
		} else {
			if(BC->pressed) {
				BC->pressed = false;
				StandardMessage sm;
				BA->com_make_default_header(&sm, BS->uid, sizeof(StandardMessage), FID_RELEASED);
				BA->send_blocking_with_timeout(&sm,
											   sizeof(StandardMessage),
											   *BA->com_current);
			}
		}
	}

	simple_tick(tick_type);
}
