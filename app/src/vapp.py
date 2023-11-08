# Copyright (c) 2023 Robert Bosch GmbH and Microsoft Corporation
#
# This program and the accompanying materials are made available under the
# terms of the Apache License, Version 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# SPDX-License-Identifier: Apache-2.0

"""A demo for a trailer with refrigeration capabilities."""

import json
import logging

from vehicle import vehicle  # type: ignore
from velocitas_sdk.util.log import (  # type: ignore
    get_opentelemetry_log_factory,
    get_opentelemetry_log_format,
)
from velocitas_sdk.vdb.reply import DataPointReply
from velocitas_sdk.vehicle_app import VehicleApp

logging.setLogRecordFactory(get_opentelemetry_log_factory())
logging.basicConfig(format=get_opentelemetry_log_format())
logging.getLogger().setLevel("DEBUG")
logger = logging.getLogger(__name__)


class RefrigerationDemo(VehicleApp):
    """
    The RefrigerationDemo supervises the temperature inside the trailer
    and triggers an alarm via a specific MQTT topic if it gets to warm
    """

    def __init__(self):
        super().__init__()
        self.Vehicle = vehicle

    async def on_start(self):
        """Run when the vehicle app starts"""
        await self.Vehicle.Trailer.InsideTemperature.subscribe(
            self.on_inside_temperature_changed
        )

    async def on_inside_temperature_changed(self, data: DataPointReply):
        target_temperature = (await self.Vehicle.Trailer.Refrigeration.TargetTemperature.get()).value
        current_temperature = data.get(self.Vehicle.Trailer.InsideTemperature).value
        hysteresis = 1 # degree Celsius
        if current_temperature > target_temperature + 2*hysteresis:
            over_temperature_topic = "trailer_refrigeration/over_temperature_warning"
            await self.publish_event(
                over_temperature_topic,
                json.dumps(
                    {
                        "warning_text": "Current temperature inside trailer exceeds target value!",
                        "current_temperature": current_temperature,
                        "target_temperature": target_temperature
                    }
                ),
            )
